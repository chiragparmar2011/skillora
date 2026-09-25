import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/utilities/app_colors.dart';

abstract class BaseController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isInnerLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    onInitSetup();
  }

  void onInitSetup() {}

  void changeLoaderStatus(bool status) {
    isLoading.value = status;
  }

  void changeInnerLoaderStatus(bool status) {
    isInnerLoading.value = status;
  }

  void showSuccess(String message) {
    if (message.isEmpty) return;
    if (Get.overlayContext == null && Get.context == null) return;
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      backgroundColor: AppColors.green,
      snackStyle: SnackStyle.FLOATING,
      message: message,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  void showError(String error) {
    if (error.isEmpty) return;
    if (Get.overlayContext == null && Get.context == null) return;
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      backgroundColor: AppColors.red,
      snackStyle: SnackStyle.FLOATING,
      message: error,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  void showMessage(String message) {
    if (message.isEmpty) return;
    if (Get.overlayContext == null && Get.context == null) return;
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      backgroundColor: AppColors.black,
      snackStyle: SnackStyle.FLOATING,
      message: message,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  void navigateTo(
    String routeName, {
    dynamic data,
    bool isClearPrevious = false,
    bool isClearAll = false,
  }) {
    if (isClearAll) {
      Get.offAllNamed(routeName, arguments: data);
    } else if (isClearPrevious) {
      Get.offNamed(routeName, arguments: data);
    } else {
      Get.toNamed(routeName, arguments: data);
    }
  }
}
