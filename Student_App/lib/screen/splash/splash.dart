import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/screen/splash/controller/splash_controller.dart';
import 'package:skillora/utilities/assets_path.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  SplashController get controller {
    if (!Get.isRegistered<SplashController>()) {
      return Get.put(SplashController());
    }
    return Get.find<SplashController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: _buildSplash()),
            ],
          ),
          _buildLogo(context),
        ],
      ),
    );
  }

  Widget _buildSplash() {
    return Obx(
      () => Image.asset(
        controller.firstScreen.value ? AssetsPath.splashOne : AssetsPath.splashTwo,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Center(
      child: Obx(
        () => Image.asset(
          controller.firstScreen.value ? AssetsPath.logoGreen : AssetsPath.logoWhite,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
