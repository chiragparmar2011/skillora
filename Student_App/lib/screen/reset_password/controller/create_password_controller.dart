import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/utilities/app_constants.dart';

class CreatePasswordController extends BaseController with ConnectivityMixin {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  String? token;

  @override
  onInitSetup() {
    // TODO: implement onInitSetup
  }

  Future<void> resetPassword() async {
    try {
      changeLoaderStatus(true);
      Map<String, String> requestData = {
        'email': emailController.text,
        'user_type': AppConstants.user,
      };
      String? message = await apiServices.resetPassword(requestData);
      changeLoaderStatus(false);
      if (message != null) {
        showSuccess(message);
        requestData.addAll({
          'screenTitle': 'login.resetPassword',
          'screenDesc': 'login.sendOtpToMail'
        });
        navigateTo(RoutePath.verifyOTP, data: requestData);
      }
    } catch (e) {
      showError(e.toString());
    }
    changeLoaderStatus(false);
  }

  Future<void> updatePassword() async {
    try {
      changeLoaderStatus(true);
      token = Get.arguments.toString();
      Map<String, String> requestData = {
        'password': passwordController.text,
        'password_confirmation': confirmPasswordController.text,
        'user_type': AppConstants.user,
        'token': token ?? '',
      };
      String? data = await apiServices.updatePassword(requestData);
      changeLoaderStatus(false);
      if (data != null) {
        showSuccess(data);
        navigateToRemoveStack(RoutePath.signIn);
      }
    } catch (e) {
      showError(e.toString());
    }
    changeLoaderStatus(false);
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
