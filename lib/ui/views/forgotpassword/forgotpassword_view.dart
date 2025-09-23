import 'package:flutter/material.dart';
import 'package:pinoki/ui/color_themes.dart';
import 'package:pinoki/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'forgotpassword_viewmodel.dart';

class ForgotpasswordView extends StackedView<ForgotpasswordViewModel> {
  const ForgotpasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForgotpasswordViewModel viewModel,
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
                TextField(
                    decoration: const InputDecoration(
                      hintText: "Enter email",
                      label: Text("Email"),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    focusNode: viewModel.forgotEmailNode,
                    controller: viewModel.forgotEmailController,
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    }),
                GestureDetector(
                    onTap: () {
                      viewModel.toggleResetBtn(context);
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
                          child: Text("Reset password",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Noto Sans',
                              ))),
                    )),
                verticalSpaceMedium,
                GestureDetector(
                  onTap: () {
                    viewModel.backToLogin();
                  },
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(color: ColorThemes.mainBackground),
                  ),
                ),
                verticalSpaceTiny,
              ],
            ),
          )),
    );
  }

  @override
  ForgotpasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgotpasswordViewModel();
}
