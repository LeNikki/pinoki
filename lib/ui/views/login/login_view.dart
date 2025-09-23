import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pinoki/ui/color_themes.dart';
import 'package:pinoki/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
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
                verticalSpaceLarge,
                Form(
                    autovalidateMode: AutovalidateMode.always,
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
                      viewModel.login(context);
                    }),
                GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      viewModel.login(context);
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
                          child: Text("Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Noto Sans',
                              ))),
                    )),
                verticalSpaceMedium,
                GestureDetector(
                  onTap: () {
                    viewModel.forgotPassword();
                  },
                  child: const Text(
                    'Forgot password',
                    style: TextStyle(color: ColorThemes.mainBackground),
                  ),
                ),
                verticalSpaceTiny,
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Sign up',
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
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
