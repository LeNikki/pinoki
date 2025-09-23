import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pinoki/ui/color_themes.dart';
import 'package:pinoki/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'signup_viewmodel.dart';

class SignupView extends StackedView<SignupViewModel> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupViewModel viewModel,
    Widget? child,
  ) {
    return  Scaffold(
      backgroundColor: ColorThemes.offwhite,
      body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text('PINOKI',
                      style: TextStyle(
                          color: ColorThemes.mainBackground,
                          fontSize: 70,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  child: const Text('Sign up',
                      style: TextStyle(
                          color: ColorThemes.mainBackground,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                verticalSpaceMedium,
                Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : 'Please enter a valid email',
                      decoration: const InputDecoration(
                        hintText: "Enter email",
                        label: Text("Email"),
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: viewModel.emailNode,
                      controller: viewModel.emailController,
                      autocorrect: false,
                    )),
                verticalSpaceSmall,
                TextField(
                    decoration: InputDecoration(
                        hintText: "Enter password",
                        label: Text("Password"),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              viewModel.togglePasswordShow();
                            },
                            icon: Icon(viewModel.showPassword
                                ? Icons.remove_red_eye
                                : Icons.visibility_off))),
                    controller: viewModel.passwordController,
                    focusNode: viewModel.passwordNode,
                    textInputAction: TextInputAction.next,
                    obscureText: viewModel.showPassword ? false : true,
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                      viewModel.gotoLogin();
                    }),
                verticalSpaceSmall,
                TextField(
                    decoration: InputDecoration(
                        hintText: "Confirm password",
                        label: Text("Confirm password"),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              viewModel.togglePasswordShow();
                            },
                            icon: Icon(viewModel.showPassword
                                ? Icons.remove_red_eye
                                : Icons.visibility_off))),
                    controller: viewModel.confirmPassController,
                    focusNode: viewModel.confirmPasswordNode,
                    textInputAction: TextInputAction.next,
                    obscureText: viewModel.showPassword ? false : true,
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                      viewModel.gotoLogin();
                    }),
                GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      viewModel.signup(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorThemes.mainBackground,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                          child: Text("Signup",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Noto Sans',
                              ))),
                    )),
                verticalSpaceMedium,
                
                GestureDetector(
                  onTap: () {viewModel.gotoLogin();},
                  child: const Text(
                    'Already have an account',
                    style: TextStyle(
                        color: ColorThemes.mainBackground,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  SignupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignupViewModel();
}
