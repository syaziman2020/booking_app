import 'package:booking_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel user = await UserService().getUserById(
        userCredential.user!.uid,
      );
      return user;
    } catch (e) {
      if (email.isEmpty || password.isEmpty) {
        throw ('Please enter email and password');
      } else if (e.toString().contains('user-not-found')) {
        throw ('User not found');
      } else if (e.toString().contains('wrong-password')) {
        throw ('Wrong password');
      } else {
        rethrow;
      }
    }
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String nim,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        nim: nim,
      );

      await UserService().setUser(user);
      return user;
    } catch (e) {
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        throw ('Please fill in all data');
      } else if (e.toString().contains('email-already-in-use')) {
        throw ('Sorry, this email already in use');
      } else if (e.toString().contains('invalid-email')) {
        throw ('Please fill in the email correctly');
      } else if (e.toString().contains('weak-password')) {
        throw ('Password should be at least 6 characters');
      } else {
        throw ('');
      }
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
