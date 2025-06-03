import 'package:flutter/material.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter email",
                label: Text("Email"),
                border: OutlineInputBorder()
              ),
              textInputAction: TextInputAction.next,
              focusNode: viewModel.emailNode,
              onSubmitted: (_) {  FocusScope.of(context).requestFocus(viewModel.passwordNode);}
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter password",
                label: Text("Password"),
                border: OutlineInputBorder()
              ),
              focusNode: viewModel.passwordNode,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => viewModel.login()
            ),
            GestureDetector(
              onTap: (){}, 
              child: Container(
                //decoration: 
                //BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     offset: Offset(0, 0),
                  //     blurRadius: 10
                  //   )
                  // ],
                  
                //),
                color:const Color.fromARGB(153, 220, 220, 220),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                child: Text("Login"),
              ))
          ],
        ),
        )
        
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
