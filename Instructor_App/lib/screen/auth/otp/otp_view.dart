import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/auth/otp/otp_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_appbar.dart';
import 'package:instructor_app/widgets/va_button.dart';
import 'package:pinput/pinput.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key});

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyles().textStyleRoboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: VAAppBar(
        title: translate(context, 'auth.verifyOtp'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                "Verification Code",
                style: TextStyles().textStyleRoboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please enter the 4-digit code sent to\n${controller.email.isNotEmpty ? controller.email : 'your email'}",
                textAlign: TextAlign.center,
                style: TextStyles().textStyleRoboto(
                  fontSize: 14,
                  color: AppColors.mentorAbout,
                ),
              ),
              const SizedBox(height: 36),
              Pinput(
                length: 4,
                controller: controller.otpController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                showCursor: true,
                onCompleted: (pin) => controller.verifyCode(),
              ),
              const SizedBox(height: 36),
              Obx(
                () => VAButton(
                  text: translate(context, 'auth.verifyOtp'),
                  isLoading: controller.isLoading.value,
                  onPressed: controller.verifyCode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
