import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/auth/sign_in/sign_in_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_button.dart';
import 'package:instructor_app/widgets/va_text_form_field.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      size: 48,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    translate(context, 'auth.welcomeBack'),
                    textAlign: TextAlign.center,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: Text(
                    translate(context, 'auth.signInSub'),
                    textAlign: TextAlign.center,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 14,
                      color: AppColors.mentorAbout,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                VATextFormField(
                  controller: controller.emailController,
                  labelText: translate(context, 'auth.email'),
                  hintText: 'instructor@skillora.edu',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined,
                      color: AppColors.mentorAbout, size: 20),
                ),
                const SizedBox(height: 18),
                Obx(
                  () => VATextFormField(
                    controller: controller.passwordController,
                    labelText: translate(context, 'auth.password'),
                    hintText: '••••••••',
                    obscureText: controller.isPasswordHidden.value,
                    prefixIcon: const Icon(Icons.lock_outline_rounded,
                        color: AppColors.mentorAbout, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.mentorAbout,
                        size: 20,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: controller.goToForgotPassword,
                    child: Text(
                      translate(context, 'auth.forgotPassword'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Obx(
                  () => VAButton(
                    text: translate(context, 'auth.signIn'),
                    isLoading: controller.isLoading.value,
                    onPressed: controller.signIn,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: controller.goToSignUp,
                    child: Text(
                      translate(context, 'auth.dontHaveAccount'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
