import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:group_chat/src/models/index.dart';
import 'package:redux/redux.dart';

class UserContainer extends StatelessWidget {
  const UserContainer({super.key, required this.builder});

  final ViewModelBuilder<User?> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User?>(
      converter: (Store<AppState> store) => store.state.authState.user,
      builder: builder,
    );
  }
}
