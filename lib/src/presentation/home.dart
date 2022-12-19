import 'package:flutter/material.dart';

import 'package:group_chat/src/models/index.dart';
import 'package:group_chat/src/presentation/containers/user_container.dart';
import 'package:group_chat/src/presentation/home_page.dart';
import 'package:group_chat/src/presentation/login_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, User? user) {
        if (user == null) {
          return const LoginPage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}
