import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/screen/routes.dart';
import 'package:instructor_app/services/api_services.dart';

class ForgotPasswordController extends BaseController {
  final emailController = TextEditingController();

  Future<void> sendResetOtp() async {
    String email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      showError("Please enter a valid email address");
      return;
    }

    try {
      changeLoaderStatus(true);
      bool success = await ApiServices().forgotPassword(email);
      if (success) {
        showSuccess("Verification code sent to $email");
        navigateTo(RoutePath.otpVerify, data: {'email': email});
      }
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
