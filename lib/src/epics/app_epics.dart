import 'package:group_chat/src/data/auth_api.dart';
import 'package:group_chat/src/epics/auth_epics.dart';
import 'package:group_chat/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';

class AppEpics {
  const AppEpics(this._authApi);

  final AuthApi _authApi;

  Epic<AppState> get epic {
    return combineEpics(<Epic<AppState>>[
      AuthEpic(_authApi).epic,
    ]);
  }
}
