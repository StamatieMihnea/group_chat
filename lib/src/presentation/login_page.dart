import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:group_chat/src/actions/index.dart';
import 'package:group_chat/src/models/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onResponse(dynamic action) {
    if (action is LoginError) {
      final Object error = action.error;
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? error.code)));
      }
    }
    if (action is CreateUserError) {
      final Object error = action.error;
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? error.code)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'email',
                  ),
                  validator: (String? email) {
                    if (email == null || !email.contains('@')) {
                      return 'The email address must be valid!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'password',
                  ),
                  validator: (String? password) {
                    if (password == null || password.length < 6) {
                      return 'Password must be greater then 6 characters!';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                Builder(
                  builder: (BuildContext context) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (Form.of(context)!.validate()) {
                                final Login loginAction = Login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  response: _onResponse,
                                );
                                StoreProvider.of<AppState>(context).dispatch(loginAction);
                              } else {
                                return;
                              }
                            },
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (Form.of(context)!.validate()) {
                                final CreateUser createUserAction = CreateUser(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  action: _onResponse,
                                );
                                StoreProvider.of<AppState>(context).dispatch(createUserAction);
                              } else {
                                return;
                              }
                            },
                            child: const Text('Create account'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
