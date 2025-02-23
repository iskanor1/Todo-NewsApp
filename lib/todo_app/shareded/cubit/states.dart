abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class AppDeleteDatabaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}

class AppChangeModeState extends AppStates {}

// Error States
class AppDatabaseErrorState extends AppStates {
  final String error; // Add an error message to handle failures
  AppDatabaseErrorState(this.error);
}
