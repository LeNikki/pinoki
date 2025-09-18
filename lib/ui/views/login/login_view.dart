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
                  child: const Text('PINOKI', style: TextStyle(
                    color: ColorThemes.mainBackground,
                    fontSize: 70,
                    fontWeight: FontWeight.bold
                  )),
                ),
                verticalSpaceLarge,
                TextField(
                    decoration: const InputDecoration(
                        hintText: "Enter email",
                        label: Text("Email"),
                        border: OutlineInputBorder(),
                        ),
                    textInputAction: TextInputAction.next,
                    focusNode: viewModel.emailNode,
                    controller: viewModel.emailController,
                    onSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(viewModel.passwordNode);
                    }),
                SizedBox(height: 10),
                TextField(
                    decoration: const InputDecoration(
                        hintText: "Enter password",
                        label: Text("Password"),
                        border: OutlineInputBorder()),
                    controller: viewModel.passwordController,
                    focusNode: viewModel.passwordNode,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => viewModel.login()),
                GestureDetector(
                    onTap: () {
                      viewModel.login();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorThemes.mainBackground,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      child: const Center(child: Text("Login", style: 
                      TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto Sans',
                        ))) ,
                    )),
                  verticalSpaceMedium,
                  GestureDetector(
                    onTap: (){},
                    child: const Text('Forgot password', style: TextStyle(
                      color: ColorThemes.mainBackground
                    ),),
                  ),
                  verticalSpaceTiny,
                  GestureDetector(
                    onTap: (){},
                    child: const Text('Sign up', style: TextStyle(
                      color: ColorThemes.mainBackground,
                      fontWeight: FontWeight.bold
                    ),),
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
