import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/model/user_model.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/utilities/app_constants.dart';

class SignUpController extends BaseController with ConnectivityMixin {
  RxBool isPasswordVisible = false.obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  Future<void> registerUser() async {
    try {
      changeLoaderStatus(true);
      Map<String, String> requestData = {
        'email': emailController.text,
        'password': passwordTextController.text,
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'device_token': SharedPreferenceHelper.getFcmToken(),
        'user_type': AppConstants.user,
      };

      UserModel? userModel = await apiServices.register(requestData);
      if (userModel != null) {
        SharedPreferenceHelper.setAuthToken(userModel.token);
        SharedPreferenceHelper.setUser(userModel);

        Map<String, String> arguments = {
          'email': emailController.text,
          'screenTitle': 'login.verifyOtp',
          'screenDesc': 'login.sendOtpToMail',
          'goToScreen': RoutePath.drawer
        };
        navigateTo(
          RoutePath.verifyOTP,
          data: arguments,
        );
      }
    } catch (e) {
      showError(e.toString());
    }
    changeLoaderStatus(false);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  onInitSetup() {
    // TODO: implement onInitSetup
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
