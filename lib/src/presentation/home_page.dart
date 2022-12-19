import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:group_chat/src/actions/index.dart';
import 'package:group_chat/src/models/index.dart';
import 'package:group_chat/src/presentation/containers/user_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, User? user) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                user!.displayName,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(const Logout());
                },
                icon: const Icon(
                  Icons.power_settings_new_rounded,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
