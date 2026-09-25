import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/reset_password/controller/create_password_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/assets_path.dart';
import 'package:skillora/widgets/va_back_button.dart';
import 'package:skillora/widgets/va_button.dart';
import 'package:skillora/widgets/va_header.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';
import 'package:skillora/widgets/va_text_field.dart';

class CreatePasswordView extends GetView<CreatePasswordController> {
  CreatePasswordView({super.key});

  @override
  CreatePasswordController get controller {
    if (!Get.isRegistered<CreatePasswordController>()) {
      return Get.put(CreatePasswordController());
    }
    return Get.find<CreatePasswordController>();
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
                    _buildMain(),
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
                  firstText: translate(MyGlobals.navKey.currentContext,
                      'profile.createNewPassword'),
                  secondText: '',
                  heightOne: 14,
                  logoHeight: 110,
                ),
                const SizedBox(height: 24),
                _buildNewPasswordField(),
                const SizedBox(height: 14),
                _buildConfirmPasswordField(),
                const SizedBox(height: 24),
                _buildPasswordButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewPasswordField() {
    return VaTextField(
      controller: controller.passwordController,
      hintText:
          translate(MyGlobals.navKey.currentContext, 'profile.newPassword'),
      obscureText: !controller.isNewPasswordVisible.value,
      validator: (value) {
        String? result = controller.validatePassword(value!);
        return result;
      },
      suffixIconButton: IconButton(
        icon: Icon(
          !controller.isNewPasswordVisible.value
              ? Icons.visibility_off
              : Icons.visibility,
          color: AppColors.darkGray,
        ),
        onPressed: () {
          controller.toggleNewPasswordVisibility();
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return VaTextField(
      controller: controller.confirmPasswordController,
      hintText:
          translate(MyGlobals.navKey.currentContext, 'profile.confirmPassword'),
      obscureText: !controller.isConfirmPasswordVisible.value,
      validator: (value) {
        if ((value ?? '').isEmpty) {
          return translate(
              MyGlobals.navKey.currentContext, 'validation.password');
        } else if (value != controller.passwordController.text) {
          return translate(
              MyGlobals.navKey.currentContext, 'validation.passwordNotMatch');
        }
        return null;
      },
      suffixIconButton: IconButton(
        icon: Icon(
          !controller.isConfirmPasswordVisible.value
              ? Icons.visibility_off
              : Icons.visibility,
          color: AppColors.darkGray,
        ),
        onPressed: () {
          controller.toggleConfirmPasswordVisibility();
        },
      ),
    );
  }

  Widget _buildPasswordButton() {
    return VAButton(
      backgroundColor: AppColors.primaryColor,
      isLoading: controller.isLoading.value,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          controller.updatePassword();
        }
      },
      text:
          translate(MyGlobals.navKey.currentContext, 'profile.changePassword'),
    );
  }
}
