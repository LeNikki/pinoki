import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinoki/app/app.dialogs.dart';
import 'package:pinoki/app/app.locator.dart';
import 'package:pinoki/app/app.router.dart';
import 'package:pinoki/core/services/authentication_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotpasswordViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final forgotEmailController = TextEditingController();
  final _authenticationService = locator<AuthenticationServices>();
  final dialogService = locator<DialogService>();

  final forgotEmailNode = FocusNode();
  bool isResetPressed = false;

  void backToLogin() {
    _navigationService.navigateToLoginView();
  }

  Future toggleResetBtn(BuildContext context) async {
    isResetPressed = !isResetPressed;
    Future.delayed(const Duration(milliseconds: 500), () {
      isResetPressed = false;
      notifyListeners();
    });
    if (isResetPressed && forgotEmailController.text.isNotEmpty) {
      var success = await _authenticationService
          .forgotPassword(forgotEmailController.text);
      if (success) {
        dialogService.showCustomDialog(
            variant: DialogType.infoAlert,
            title: 'Success',
            description:
                'A reset instruction has been sent to your email. Please check the Spam folder.',
            mainButtonTitle: 'Okay');
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Wrong Email'),
                  content: const Text('Please enter a correct email'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      }
    } else if (forgotEmailController.text.isEmpty) {
      dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          title: 'Error',
          description: 'Please enter a valid email',
          mainButtonTitle: 'Okay');
    }
  }
}
