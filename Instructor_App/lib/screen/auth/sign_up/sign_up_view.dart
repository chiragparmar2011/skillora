import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/auth/sign_up/sign_up_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_appbar.dart';
import 'package:instructor_app/widgets/va_button.dart';
import 'package:instructor_app/widgets/va_text_form_field.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: VAAppBar(
        title: translate(context, 'auth.signUp'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate(context, 'auth.createAccount'),
                style: TextStyles().textStyleRoboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                translate(context, 'auth.signUpSub'),
                style: TextStyles().textStyleRoboto(
                  fontSize: 13,
                  color: AppColors.mentorAbout,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: VATextFormField(
                      controller: controller.firstNameController,
                      labelText: translate(context, 'auth.firstName'),
                      hintText: 'Robert',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: VATextFormField(
                      controller: controller.lastNameController,
                      labelText: translate(context, 'auth.lastName'),
                      hintText: 'Fox',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              VATextFormField(
                controller: controller.emailController,
                labelText: translate(context, 'auth.email'),
                hintText: 'robert.fox@skillora.edu',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined,
                    color: AppColors.mentorAbout, size: 20),
              ),
              const SizedBox(height: 16),
              VATextFormField(
                controller: controller.phoneController,
                labelText: translate(context, 'auth.phone'),
                hintText: '+1 555 019 2834',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined,
                    color: AppColors.mentorAbout, size: 20),
              ),
              const SizedBox(height: 16),
              Text(
                translate(context, 'auth.category'),
                style: TextStyles().textStyleRoboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 6),
              Obx(
                () => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.platinumBorder),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectedCategory.value,
                      items: controller.categories
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(
                                c,
                                style: TextStyles().textStyleRoboto(
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          controller.selectedCategory.value = val;
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              VATextFormField(
                controller: controller.headlineController,
                labelText: translate(context, 'auth.headline'),
                hintText: translate(context, 'auth.headlineHint'),
              ),
              const SizedBox(height: 16),
              VATextFormField(
                controller: controller.bioController,
                labelText: translate(context, 'auth.bio'),
                hintText: translate(context, 'auth.bioHint'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 30),
              Obx(
                () => VAButton(
                  text: translate(context, 'auth.signUp'),
                  isLoading: controller.isLoading.value,
                  onPressed: controller.register,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: controller.goToSignIn,
                  child: Text(
                    translate(context, 'auth.alreadyHaveAccount'),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
