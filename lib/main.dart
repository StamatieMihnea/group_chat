import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:group_chat/firebase_options.dart';
import 'package:group_chat/src/data/auth_api.dart';
import 'package:group_chat/src/epics/app_epics.dart';
import 'package:group_chat/src/models/index.dart';
import 'package:group_chat/src/presentation/chat_page.dart';
import 'package:group_chat/src/presentation/home.dart';
import 'package:group_chat/src/reducers/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final AuthApi authApi = AuthApi(auth: FirebaseAuth.instance);
  final AppEpics epics = AppEpics(authApi);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epics.epic),
    ],
  );
  runApp(
    ChatApp(
      store: store,
    ),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key, required this.store});

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Chat app',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const Home(),
          '/chat': (BuildContext context) => const ChatPage(),
        },
      ),
    );
  }
}
