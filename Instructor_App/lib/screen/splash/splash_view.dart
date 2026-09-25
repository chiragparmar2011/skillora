import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/splash/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  SplashController get controller {
    if (!Get.isRegistered<SplashController>()) {
      return Get.put(SplashController());
    }
    return Get.find<SplashController>();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // Background doodle wallpaper
          Positioned.fill(
            child: Obx(
              () => Image.asset(
                controller.firstScreen.value
                    ? 'assets/images/splash_one.png'
                    : 'assets/images/splash_two.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          // Centered Brand Logo with smooth cross-fade animation
          Center(
            child: Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: Image.asset(
                  controller.firstScreen.value
                      ? 'assets/images/logo_green.png'
                      : 'assets/images/logo_white.png',
                  key: ValueKey<bool>(controller.firstScreen.value),
                  width: screenWidth * 0.65,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Subtle loading indicator at bottom
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(
                () => SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      controller.firstScreen.value
                          ? const Color(0xFFEA580C)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
