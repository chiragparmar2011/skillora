import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/helper/shared_preference_helper.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/screen/routes.dart';
import 'package:instructor_app/services/api_services.dart';

class SignInController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void fillDemoCredentials() {
    emailController.text = "robert.fox@skillora.edu";
    passwordController.text = "password123";
  }

  Future<void> signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      showError("Please enter a valid email address");
      return;
    }
    if (password.isEmpty || password.length < 6) {
      showError("Password must be at least 6 characters");
      return;
    }

    try {
      changeLoaderStatus(true);
      var user = await ApiServices().login(email, password);
      if (user != null) {
        await SharedPreferenceHelper.setAuthToken(user.token ?? 'valid_token');
        await SharedPreferenceHelper.setInstructorInfo(user.toJson());
        showSuccess("Welcome back, ${user.fullName}!");
        navigateTo(RoutePath.dashboard, isClearAll: true);
      } else {
        showError("Invalid email or password");
      }
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  void goToSignUp() {
    navigateTo(RoutePath.signUp);
  }

  void goToForgotPassword() {
    navigateTo(RoutePath.forgotPassword);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
