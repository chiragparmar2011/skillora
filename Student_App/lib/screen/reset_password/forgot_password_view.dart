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

class ForgotPasswordView extends GetView<CreatePasswordController> {
  ForgotPasswordView({super.key});

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
                    Expanded(child: _buildMain()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildMain() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VAHeader(
                  assetImage: AssetsPath.logoGreen,
                  firstText: 'Reset Password',
                  secondText: '',
                  heightOne: 14,
                  logoHeight: 110,
                ),
                const SizedBox(height: 24),
                _buildRecoverPassword(),
                const SizedBox(height: 24),
                _buildResetPasswordButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecoverPassword() {
    return VaTextField(
      controller: controller.emailController,
      hintText: translate(MyGlobals.navKey.currentContext, 'profile.email'),
      validator: (String? value) {
        if ((value ?? '').isEmpty) {
          return translate(MyGlobals.navKey.currentContext, 'validation.email');
        }
        return null;
      },
    );
  }

  Widget _buildResetPasswordButton() {
    return VAButton(
      backgroundColor: AppColors.primaryColor,
      isLoading: controller.isLoading.value,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          controller.resetPassword();
        }
      },
      text: translate(MyGlobals.navKey.currentContext, 'login.sendOtp'),
    );
  }
}
