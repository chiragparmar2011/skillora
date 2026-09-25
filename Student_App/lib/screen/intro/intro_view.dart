import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/intro/controller/intro_controller.dart';
import 'package:skillora/screen/intro/model/intro_model.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_button.dart';
import 'package:skillora/widgets/va_image_asset.dart';

class IntroView extends GetView<IntroController> {
  const IntroView({super.key});

  @override
  IntroController get controller {
    if (!Get.isRegistered<IntroController>()) {
      return Get.put(IntroController());
    }
    return Get.find<IntroController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 40),
          _buildSkipButton(),
          _buildPage(),
          _buildPageIndicator(),
          const SizedBox(height: 38),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return TextButton(
      onPressed: () {
        controller.skipIntroduction();
      },
      child: Text(
        'SKIP',
        style: TextStyles().textStyleRoboto(
          color: AppColors.rootBeer,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildPageView(List<IntroModel> data, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VAImageAsset(
          image: data[index].imageAsset,
          height: 250,
          width: 300,
        ),
        const SizedBox(height: 40),
        Text(
          data[index].title,
          style: TextStyles().textStyleRoboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          data[index].subtitle,
          style: TextStyles().textStyleRoboto(
            fontSize: 16,
            color: AppColors.quartz,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < controller.walkThroughData.length; i++) {
      indicators.add(
        Obx(
          () => AnimatedContainer(
            curve: Curves.easeIn,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            duration: const Duration(milliseconds: 500),
            width: (i == controller.currentPageIndex.value) ? 30 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: (i == controller.currentPageIndex.value)
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: VAButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          controller.nextPage();
        },
        text: translate(MyGlobals.navKey.currentContext, 'common.next'),
      ),
    );
  }

  Widget _buildPage() {
    return Expanded(
      child: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.walkThroughData.length,
        onPageChanged: (int index) {
          controller.currentPageIndex.value = index;
        },
        itemBuilder: (BuildContext context, int index) {
          return _buildPageView(controller.walkThroughData, index);
        },
      ),
    );
  }
}
