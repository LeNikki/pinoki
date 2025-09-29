import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinoki/resources/svg_images.dart';
import 'package:pinoki/ui/color_themes.dart';
import 'package:stacked/stacked.dart';
import 'package:pinoki/ui/common/app_colors.dart';
import 'package:pinoki/ui/common/ui_helpers.dart';
import 'dart:math' as math;
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:SizedBox.expand(
          child: Stack(children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey))
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:Border.all(color: ColorThemes.mainBackground)
                  ),
                  child: Row(children: [
                   Expanded(
                    child: TextField(
                      controller: viewModel.askInputController,
                      decoration: const InputDecoration(
                      hintText: 'Ask anything',
                      border: InputBorder.none
                      ),
                      maxLines: 6,
                      minLines: 1,
                    ),
                    ),
                    Container(
                      width: 60,
                      height: 30,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorThemes.mainBackground,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Text('Send', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                  ),
                ],))
              ))
          ],)
      )),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
