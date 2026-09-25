import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';

class ChangePasswordController extends BaseController with ConnectivityMixin {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  @override
  onInitSetup() {
    // TODO: implement onInitSetup
  }

  Future<void> changePassword() async {
    try {
      changeLoaderStatus(true);
      Map<String, String> requestData = {
        'old_password': oldPasswordController.text,
        'new_password': passwordController.text,
        'confirm_password': confirmPasswordController.text,
      };
      String? data = await apiServices.changePassword(requestData);
      changeLoaderStatus(false);
      if (data != null) {
        showSuccess(data);
        Get.close(1);
      }
    } catch (e) {
      changeLoaderStatus(false);
      showError(e.toString());
    }
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
