import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/news_app/cubit/states.dart';
import 'package:new_app/news_app/moduels/bussines/bussines_screen.dart';
import 'package:new_app/news_app/moduels/science/sciences_screen.dart';
import 'package:new_app/news_app/network/remote/dio_helper.dart';
import 'package:new_app/news_app/settings/settings_screen.dart';
import 'package:dio/dio.dart';

import '../moduels/sports/sports_screen.dart';

class NewCubit extends Cubit<NewsStates> {
  NewCubit() : super(NewsInitiaState());

  static NewCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1)
      getSports();
    if (index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  // Explicitly declare lists as List<Map<dynamic, dynamic>>
  List<Map<dynamic, dynamic>> business = [];
  List<Map<dynamic, dynamic>> sports = [];
  List<Map<dynamic, dynamic>> science = [];

  void getBusiness() {
    emit(NewsLoadingState());

    DioHelper.getData(
      url: 'api/1/latest',
      query: {
        'country': 'eg',
        'category': 'business',
        'apikey ': 'pub_711959df19a68ad4832dffa5c10dc10859e3f',
      },
    ).then((value) {
      if (value.data != null && value.data['results'] != null) {
        // Cast the data to List<Map<dynamic, dynamic>>
        business = List<Map<dynamic, dynamic>>.from(value.data['results']);
        print(business[0]['title']);
        emit(NewsBusinessSuccessState());
      } else {
        throw Exception('No data found');
      }
    }).catchError((error) {
      print(error.toString());
      emit(NewsBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsSportsLoadingState());

    if (sports.isEmpty) {
      DioHelper.getData(
          url: 'api/1/latest',
          query: {
            'country': 'eg',
            'category': 'sports',
            'apikey ': 'pub_711959df19a68ad4832dffa5c10dc10859e3f',
          },
      ).then((value) {
        if (value.data != null && value.data['results'] != null) {
          // Cast the data to List<Map<dynamic, dynamic>>
          sports = List<Map<dynamic, dynamic>>.from(value.data['results']);
          print(sports[0]['title']);
          emit(NewsSportsSuccessState());
        } else {
          throw Exception('No data found');
        }
      }).catchError((error) {
        print(error.toString());
        emit(NewsSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsScienceLoadingState());

    if (science.isEmpty) {
      DioHelper.getData(
          url: 'api/1/latest',
          query: {
            'country': 'eg',
            'category': 'science',
            'apikey ': 'pub_711959df19a68ad4832dffa5c10dc10859e3f',
          },
      ).then((value) {
        if (value.data != null && value.data['results'] != null) {
          // Cast the data to List<Map<dynamic, dynamic>>
          science = List<Map<dynamic, dynamic>>.from(value.data['results']);
          print(science[0]['title']);
          emit(NewsScienceSuccessState());
        } else {
          throw Exception('No data found');
        }
      }).catchError((error) {
        print(error.toString());
        emit(NewsScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsScienceSuccessState());
    }
  }
}