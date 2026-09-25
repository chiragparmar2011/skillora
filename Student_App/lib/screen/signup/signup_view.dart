import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/signup/controller/signup_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/assets_path.dart';
import 'package:skillora/widgets/va_back_button.dart';
import 'package:skillora/widgets/va_button.dart';
import 'package:skillora/widgets/va_header.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';
import 'package:skillora/widgets/va_text_field.dart';

class SignUpView extends GetView<SignUpController> {
  SignUpView({super.key});

  @override
  SignUpController get controller {
    if (!Get.isRegistered<SignUpController>()) {
      return Get.put(SignUpController());
    }
    return Get.find<SignUpController>();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => controller.isInternetConnected
                ? const VANoInternetAsset()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 12),
                        child: VABackButton(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            VAHeader(
                              assetImage: AssetsPath.logoGreen,
                              firstText: translate(
                                  MyGlobals.navKey.currentContext,
                                  'login.welcome'),
                              secondText: translate(
                                  MyGlobals.navKey.currentContext,
                                  'login.createAccount'),
                              heightOne: 12,
                              heightTwo: 6,
                              logoHeight: 110,
                            ),
                            _buildForm(),
                            const SizedBox(height: 24),
                            _buildSignUpButton(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildFirstNameField(),
          const SizedBox(height: 14),
          _buildLastNameField(),
          const SizedBox(height: 14),
          _buildEmailField(),
          const SizedBox(height: 14),
          _buildPasswordField(),
        ],
      ),
    );
  }

  Widget _buildFirstNameField() {
    return VaTextField(
      controller: controller.firstNameController,
      headerText: translate(MyGlobals.navKey.currentContext, 'profile.firstName'),
      hintText: translate(MyGlobals.navKey.currentContext, 'profile.firstName'),
      validator: (String? value) {
        if ((value ?? '').isEmpty) {
          return translate(
              MyGlobals.navKey.currentContext, 'validation.firstName');
        }
        return null;
      },
    );
  }

  Widget _buildLastNameField() {
    return VaTextField(
      controller: controller.lastNameController,
      headerText: translate(MyGlobals.navKey.currentContext, 'profile.lastName'),
      hintText: translate(MyGlobals.navKey.currentContext, 'profile.lastName'),
      validator: (String? value) {
        if ((value ?? '').isEmpty) {
          return translate(
              MyGlobals.navKey.currentContext, 'validation.lastName');
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return VaTextField(
      controller: controller.emailController,
      headerText: translate(MyGlobals.navKey.currentContext, 'profile.email'),
      hintText: translate(MyGlobals.navKey.currentContext, 'profile.email'),
      validator: (String? value) {
        return controller.validateEmail(value ?? '');
      },
    );
  }

  Widget _buildPasswordField() {
    return Obx(() {
      return VaTextField(
        controller: controller.passwordTextController,
        headerText:
            translate(MyGlobals.navKey.currentContext, 'profile.password'),
        obscureText: !controller.isPasswordVisible.value,
        hintText:
            translate(MyGlobals.navKey.currentContext, 'profile.password'),
        validator: (String? value) {
          String? result = controller.validatePassword(value!);
          return result;
        },
        suffixIconButton: IconButton(
          icon: Icon(
            !controller.isPasswordVisible.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.darkGray,
          ),
          onPressed: () {
            controller.togglePasswordVisibility();
          },
        ),
      );
    });
  }

  Widget _buildSignUpButton() {
    return Obx(
      () => VAButton(
        backgroundColor: AppColors.primaryColor,
        isLoading: controller.isLoading.value,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.registerUser();
          }
        },
        text: translate(MyGlobals.navKey.currentContext, 'login.signUp')
            .toUpperCase(),
      ),
    );
  }
}
