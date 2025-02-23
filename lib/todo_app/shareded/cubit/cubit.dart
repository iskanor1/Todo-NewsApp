import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/todo_app/shareded/cubit/states.dart';

import 'package:sqflite/sqflite.dart';
import '../../modulesss/archived_tasks/archived_tasks_screen.dart';
import '../../modulesss/done_tasks/done_tasks_screen.dart';
import '../../modulesss/newtasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksscreen(),
    ArchivedTasksscreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database; // Make database nullable
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)',
        );
        emit(AppCreateDatabaseState());
      },
      onOpen: (database) {
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    }).catchError((error) {
      emit(AppDatabaseErrorState(error.toString()));
    });
  }

  Future<void> insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    if (database == null) {
      emit(AppDatabaseErrorState('Database is not initialized'));
      return;
    }

    await database!.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES(?, ?, ?, ?)',
        [title, date, time, 'new'],
      ).then((value) {
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database!);
      }).catchError((error) {
        emit(AppDatabaseErrorState(error.toString()));
      });
    });
  }

  void getDataFromDatabase(Database database) {
    newTasks.clear();
    doneTasks.clear();
    archivedTasks.clear();

    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      }
      emit(AppGetDatabaseState());
    }).catchError((error) {
      emit(AppDatabaseErrorState(error.toString()));
    });
  }

  Future<void> updateData({
    required String status,
    required int id,
  }) async {
    if (database == null) {
      emit(AppDatabaseErrorState('Database is not initialized'));
      return;
    }

    await database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database!);
      emit(AppUpdateDatabaseState());
    }).catchError((error) {
      emit(AppDatabaseErrorState(error.toString()));
    });
  }

  Future<void> deleteData({
    required int id,
  }) async {
    if (database == null) {
      emit(AppDatabaseErrorState('Database is not initialized'));
      return;
    }

    await database!.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database!);
      emit(AppDeleteDatabaseState());
    }).catchError((error) {
      emit(AppDatabaseErrorState(error.toString()));
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}