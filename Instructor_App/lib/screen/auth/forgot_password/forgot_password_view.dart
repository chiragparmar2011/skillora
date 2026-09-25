import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/auth/forgot_password/forgot_password_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_appbar.dart';
import 'package:instructor_app/widgets/va_button.dart';
import 'package:instructor_app/widgets/va_text_form_field.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: VAAppBar(
        title: translate(context, 'auth.forgotPassword'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reset Password",
                style: TextStyles().textStyleRoboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Enter your registered instructor email and we will send you a verification code to reset your password.",
                style: TextStyles().textStyleRoboto(
                  fontSize: 14,
                  color: AppColors.mentorAbout,
                ),
              ),
              const SizedBox(height: 28),
              VATextFormField(
                controller: controller.emailController,
                labelText: translate(context, 'auth.email'),
                hintText: 'instructor@skillora.edu',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined,
                    color: AppColors.mentorAbout, size: 20),
              ),
              const SizedBox(height: 30),
              Obx(
                () => VAButton(
                  text: translate(context, 'auth.sendOtp'),
                  isLoading: controller.isLoading.value,
                  onPressed: controller.sendResetOtp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
