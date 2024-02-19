import 'package:firebase_auth/firebase_auth.dart';

enum MyUser { nullUser, user, admin, supervisor }

class MyAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<MyUser> login(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (email.contains("supervisor")) {
        return MyUser.supervisor;
      } else if (email.contains("admin")) {
        return MyUser.admin;
      } else {
        return MyUser.user;
      }
    } catch (e) {
      return MyUser.nullUser;
    }
  }

  Future<MyUser> register(
      {required String email, required String password}) async {
    if (email.contains("ct") &&
        (email.contains("supervisor") ||
            email.contains("user") ||
            email.contains("admin"))) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (email.contains("supervisor")) {
          return MyUser.supervisor;
        } else if (email.contains("admin")) {
          return MyUser.admin;
        } else {
          return MyUser.user;
        }
      } catch (e) {
        return MyUser.nullUser;
      }
    } else {
      return MyUser.nullUser;
    }
  }
}
