import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/intro/model/intro_model.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/assets_path.dart';

class IntroController extends BaseController {
  final PageController pageController = PageController(initialPage: 0);
  var currentPageIndex = 0.obs;

  final List<IntroModel> walkThroughData = [
    IntroModel(
      title: translate(
          MyGlobals.navKey.currentContext, 'common.intro.screenOneTitle'),
      subtitle: translate(
          MyGlobals.navKey.currentContext, 'common.intro.screenOneTitle'),
      imageAsset: AssetsPath.introOne,
    ),
    IntroModel(
      title: translate(
          MyGlobals.navKey.currentContext, 'common.intro.screenTwoTitle'),
      subtitle: translate(
          MyGlobals.navKey.currentContext, 'common.intro.screenTwoSubTitle'),
      imageAsset: AssetsPath.introTwo,
    ),
    IntroModel(
      title: translate(
          MyGlobals.navKey.currentContext, 'common.intro.screenThreeTitle'),
      subtitle: translate(
          MyGlobals.navKey.currentContext, 'common.intro.screenThreeSubTitle'),
      imageAsset: AssetsPath.introThree,
    ),
  ];

  void nextPage() {
    if (currentPageIndex.value == walkThroughData.length - 1) {
      skipIntroduction();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  void skipIntroduction() async {
    await SharedPreferenceHelper.setBool(
        SharedPreferenceHelper.introDone, true);
    navigateToRemoveStack(RoutePath.signIn);
  }

  @override
  onInitSetup() {
    // TODO: implement onInitSetup
  }
}
