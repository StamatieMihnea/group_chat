import 'package:group_chat/src/actions/index.dart';
import 'package:group_chat/src/data/auth_api.dart';
import 'package:group_chat/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/transformers.dart';

class AuthEpic {
  const AuthEpic(this._authApi);

  final AuthApi _authApi;

  Epic<AppState> get epic {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, LoginStart>(_loginUser),
      TypedEpic<AppState, LogoutStart>(_logoutUser),
      TypedEpic<AppState, CreateUserStart>(_createUser)
    ]);
  }

  Stream<dynamic> _loginUser(
      Stream<LoginStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((LoginStart startAction) {
      return Stream<void>.value(null)
          .asyncMap((_) => _authApi.login(
              email: startAction.email, password: startAction.password))
          .map((User user) => Login.successful(user))
          .onErrorReturnWith((Object error, StackTrace stackTrace) =>
              Login.error(error, stackTrace))
          .doOnData(startAction.response);
    });
  }

  Stream<dynamic> _logoutUser(
      Stream<LogoutStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((LogoutStart startAction) {
      return Stream<void>.value(null)
          .asyncMap((_) => _authApi.logout())
          .map((_) => const Logout.successful())
          .onErrorReturnWith((Object error, StackTrace stackTrace) =>
              Logout.error(error, stackTrace));
    });
  }

  Stream<dynamic> _createUser(
      Stream<CreateUserStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((CreateUserStart startAction) {
      return Stream<void>.value(null)
          .asyncMap((_) => _authApi.createUser(
              email: startAction.email, password: startAction.password))
          .map((User user) => CreateUser.successful(user))
          .onErrorReturnWith((Object error, StackTrace stackTrace) =>
              CreateUser.error(error, stackTrace))
          .doOnData(startAction.action);
    });
  }
}
