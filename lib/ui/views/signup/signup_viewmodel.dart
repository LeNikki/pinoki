import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinoki/app/app.locator.dart';
import 'package:pinoki/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends BaseViewModel {
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final _navigationService = locator<NavigationService>();
  bool showPassword = false;
  bool showConfrimPass = false;

  void togglePasswordShow(){
    showPassword = !showPassword;
    notifyListeners();
  }

  void toggleConfirmPassShow(){
    showConfrimPass  = !showConfrimPass;
    notifyListeners();
  }

  Future<void> signup(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPassController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful!')),
      );
    } on FirebaseAuthException catch (e) {
        if(e.code.isNotEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Signup failed')),
        );
      }
    }
  }

  void gotoLogin(){
    _navigationService.navigateToLoginView();
  }
}
