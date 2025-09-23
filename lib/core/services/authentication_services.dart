import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  Future<bool> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print('${e}');
      return false;
    }
  }
}
