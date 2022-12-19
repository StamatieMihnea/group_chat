import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_chat/src/models/index.dart' as app_user;

class AuthApi {
  AuthApi({required this.auth});

  final FirebaseAuth auth;

  Future<app_user.User> createUser(
      {required String email, required String password}) async {
    final UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User loggedInUser = credential.user!;
    final String displayName = email.split('@').first;

    await loggedInUser.updateDisplayName(displayName);

    return app_user.User(
      uid: loggedInUser.uid,
      email: email,
      displayName: displayName,
    );
  }

  Future<app_user.User> login(
      {required String email, required String password}) async {
    final UserCredential credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User loggedInUser = credential.user!;
    return app_user.User(
      uid: loggedInUser.uid,
      email: loggedInUser.email!,
      displayName: loggedInUser.displayName!,
    );
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
