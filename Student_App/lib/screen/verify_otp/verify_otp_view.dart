import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/verify_otp/controller/otp_verify_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/utilities/assets_path.dart';
import 'package:skillora/widgets/va_back_button.dart';
import 'package:skillora/widgets/va_button.dart';
import 'package:skillora/widgets/va_header.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class VerifyOTPView extends GetView<OTPVerifyController> {
  VerifyOTPView({super.key});

  @override
  OTPVerifyController get controller {
    if (!Get.isRegistered<OTPVerifyController>()) {
      return Get.put(OTPVerifyController());
    }
    return Get.find<OTPVerifyController>();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: Obx(
          () => controller.isInternetConnected
              ? const VANoInternetAsset()
              : Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 12),
                        child: VABackButton(),
                      ),
                    ),
                    Expanded(child: _buildMain()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildMain() {
    return Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VAHeader(
                  assetImage: AssetsPath.logoGreen,
                  firstText: translate(
                    MyGlobals.navKey.currentContext,
                    controller.screenTitle,
                  ),
                  secondText: translate(
                    MyGlobals.navKey.currentContext,
                    controller.screenDesc,
                  ),
                  heightOne: 14,
                  heightTwo: 8,
                  logoHeight: 110,
                  fontSize: 15,
                ),
                const SizedBox(height: 24),
                _buildOTPView(),
                const SizedBox(height: 24),
                _buildOTPVerifyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOTPView() {
    return Pinput(
      controller: controller.otpController,
      length: 6,
      toolbarEnabled: false,
      defaultPinTheme: defaultPinTheme,
    );
  }

  final defaultPinTheme = PinTheme(
    width: 52,
    height: 56,
    textStyle: TextStyles().textStyleRoboto(
      fontSize: 22,
      color: AppColors.black,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.secondaryColor),
    ),
  );

  Widget _buildOTPVerifyButton() {
    return Obx(
      () => VAButton(
        backgroundColor: AppColors.primaryColor,
        isLoading: controller.isLoading.value,
        onPressed: () {
          controller.otpVerify();
        },
        text: translate(MyGlobals.navKey.currentContext, 'login.otpVerify'),
      ),
    );
  }
}
