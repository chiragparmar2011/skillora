import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/screen/routes.dart';
import 'package:instructor_app/services/api_services.dart';

class OtpController extends BaseController {
  final otpController = TextEditingController();
  String email = '';

  @override
  void onInitSetup() {
    if (Get.arguments != null && Get.arguments is Map) {
      email = Get.arguments['email'] ?? '';
    }
  }

  Future<void> verifyCode() async {
    String otp = otpController.text.trim();
    if (otp.length < 4) {
      showError("Please enter the complete 4-digit code");
      return;
    }

    try {
      changeLoaderStatus(true);
      bool success = await ApiServices().verifyOtp(otp);
      if (success) {
        showSuccess("Code verified successfully! Welcome to your dashboard.");
        navigateTo(RoutePath.dashboard, isClearAll: true);
      }
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
