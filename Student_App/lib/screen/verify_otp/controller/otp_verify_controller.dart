import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/translation/localization_delegates.dart';

class OTPVerifyController extends BaseController with ConnectivityMixin {
  TextEditingController? otpController;
  String email = "";
  String screenTitle = "";
  String screenDesc = "";
  String goToScreen = "";

  FocusNode? currentFocus;
  FocusNode? nextFocus;

  @override
  onInitSetup() {
    otpController = TextEditingController();
    email = Get.arguments['email'].toString();
    screenTitle = Get.arguments['screenTitle'].toString();
    screenDesc = Get.arguments['screenDesc'].toString();
    goToScreen = Get.arguments['goToScreen'].toString();
  }

  Future<void> otpVerify() async {
    try {
      changeLoaderStatus(true);
      Map<String, String> requestData = Get.arguments as Map<String, String>;
      requestData.addAll({
        'email': email,
        'otp': otpController?.text ?? '',
      });
      String? token = await apiServices.otpVerify(requestData);
      changeLoaderStatus(false);
      if (token != null) {
        showSuccess(
            translate(MyGlobals.navKey.currentContext, 'login.otpVerified'));

        if (goToScreen == RoutePath.createPassword) {
          navigateTo(
            goToScreen,
            data: token,
          );
        } else {
          navigateToRemoveStack(
            RoutePath.drawer,
          );
        }
      }
    } catch (e) {
      showError(e.toString());
    }
    changeLoaderStatus(false);
  }

  @override
  void onClose() {
    otpController?.dispose();
    super.onClose();
  }
}
