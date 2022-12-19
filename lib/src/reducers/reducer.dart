import 'package:flutter/foundation.dart';
import 'package:group_chat/src/actions/index.dart';
import 'package:group_chat/src/models/index.dart';
import 'package:group_chat/src/reducers/auth_reducer.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  (AppState state, dynamic action) {
    if (kDebugMode) {
      print(action);
    }
    return state;
  },
  _loginReducer,
  TypedReducer<AppState, LogoutSuccessful>(_logoutSuccessful),
]);

AppState _loginReducer(AppState state, dynamic action) {
  return state.copyWith(
    authState: authReducer(state.authState, action),
  );
}

AppState _logoutSuccessful(AppState state, LogoutSuccessful action) {
  return const AppState();
}
