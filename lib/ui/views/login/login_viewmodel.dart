import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(){
    
  }
}
