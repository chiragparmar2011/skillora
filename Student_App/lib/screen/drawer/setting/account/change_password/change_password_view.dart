import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/setting/account/change_password/controller/change_password_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_button.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';
import 'package:skillora/widgets/va_text_field.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  ChangePasswordView({super.key});

  final ChangePasswordController _controller =
      Get.put(ChangePasswordController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            VAAppBar(
              appBarTitle: translate(
                  MyGlobals.navKey.currentContext, 'profile.changePassword'),
            ),
            Expanded(
              child: Obx(
                () => controller.isInternetConnected
                    ? const VANoInternetAsset()
                    : _buildMain(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMain() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildOldPasswordField(),
              const SizedBox(height: 20),
              _buildNewPasswordField(),
              const SizedBox(height: 20),
              _buildConfirmPasswordField(),
              const SizedBox(height: 20),
              _buildPasswordButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOldPasswordField() {
    return VaTextField(
      controller: _controller.oldPasswordController,
      hintText:
          translate(MyGlobals.navKey.currentContext, 'profile.oldPassword'),
      validator: (String? value) {
        String? result = _controller.validatePassword(value!);
        return result;
      },
    );
  }

  Widget _buildNewPasswordField() {
    return VaTextField(
      controller: _controller.passwordController,
      hintText:
          translate(MyGlobals.navKey.currentContext, 'profile.newPassword'),
      obscureText: !_controller.isNewPasswordVisible.value,
      validator: (String? value) {
        String? result = _controller.validatePassword(value!);
        return result;
      },
      suffixIconButton: IconButton(
        icon: Icon(
          !_controller.isNewPasswordVisible.value
              ? Icons.visibility
              : Icons.visibility_off,
          color: AppColors.darkGray,
        ),
        onPressed: () {
          _controller.toggleNewPasswordVisibility();
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return VaTextField(
      controller: _controller.confirmPasswordController,
      hintText:
          translate(MyGlobals.navKey.currentContext, 'profile.confirmPassword'),
      obscureText: !_controller.isConfirmPasswordVisible.value,
      validator: (String? value) {
        if ((value ?? '').isEmpty) {
          return translate(MyGlobals.navKey.currentContext, 'profile.password');
        } else if (value != _controller.passwordController.text) {
          return translate(
              MyGlobals.navKey.currentContext, 'profile.passwordNotMatch');
        }
        return null;
      },
      suffixIconButton: IconButton(
        icon: Icon(
          !_controller.isConfirmPasswordVisible.value
              ? Icons.visibility
              : Icons.visibility_off,
          color: AppColors.darkGray,
        ),
        onPressed: () {
          _controller.toggleConfirmPasswordVisibility();
        },
      ),
    );
  }

  Widget _buildPasswordButton() {
    return VAButton(
      backgroundColor: AppColors.primaryColor,
      isLoading: _controller.isLoading.value,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _controller.changePassword();
        }
      },
      text:
          translate(MyGlobals.navKey.currentContext, 'profile.changePassword'),
    );
  }
}
