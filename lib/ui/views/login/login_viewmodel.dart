import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinoki/app/app.dialogs.dart';
import 'package:pinoki/app/app.locator.dart';
import 'package:pinoki/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  bool showPassword = false;

  void signup() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void login(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          title: 'Missing fields',
          description: 'Please enter your email and password.',
          mainButtonTitle: 'Okay');
      return;
    }
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (credential != null) {
        _navigationService.replaceWithHomeView();
      } else {
        dialogService.showCustomDialog(
            variant: DialogType.infoAlert,
            title: 'Error login',
            description: 'Please enter correct email and password',
            mainButtonTitle: 'Okay');
      }

      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code.isNotEmpty) {
        dialogService.showCustomDialog(
            variant: DialogType.infoAlert,
            title: 'Error login',
            description: 'Please enter correct email and password',
            mainButtonTitle: 'Okay');
      } 
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();

    // Disconnect the Google account
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
    }
    _navigationService.replaceWithLoginView();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // Once signed in, return the UserCredential
    if (user != null) {
      _navigationService.replaceWithHomeView();
    }
    return user;
  }

  void forgotPassword() {
    _navigationService.navigateToForgotpasswordView();
  }

  void gotoSignup() {
    _navigationService.navigateToSignupView();
  }

  void togglePasswordShow() {
    showPassword = !showPassword;
    notifyListeners();
  }
}
