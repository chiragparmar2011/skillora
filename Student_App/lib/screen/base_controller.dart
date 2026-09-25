import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/services/api_services.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';

abstract class BaseController extends GetxController {
  final ApiServices apiServices = ApiServices();
  RxBool isLoading = false.obs;
  RxBool isInnerLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onInitSetup();
  }

  onInitSetup() {}

  void navigateToBack() {
    Get.back();
  }

  bool isDemoUser() {
    return SharedPreferenceHelper.getUser() == null;
  }

  Future navigateTo(String routeName, {dynamic data}) async {
    return await Get.toNamed(routeName, arguments: data);
  }

  void navigateAndRemoveCurrent(String routeName) {
    Get.offNamed(routeName);
  }

  void navigateToRemoveStack(String routeName) {
    Get.offAllNamed(routeName);
  }

  String? validateEmail(String value) {
    if ((value).isEmpty) {
      return translate(MyGlobals.navKey.currentContext, 'validation.email');
    } else if (!GetUtils.isEmail(value)) {
      return translate(
          MyGlobals.navKey.currentContext, 'validation.validEmail');
    }
    return null;
  }

  String? validatePassword(String value) {
    final passwordRegex = RegExp(
        r'^(?=.*\d)(?=.*[!@#\$%^&*()_+{}\[\]:;<>,.?~\\/-])(?=.*[A-Z])(?=.*[a-z]).{8,}$');

    if (value.isEmpty) {
      return translate(MyGlobals.navKey.currentContext, 'validation.password');
    } else if (!passwordRegex.hasMatch(value)) {
      return translate(
          MyGlobals.navKey.currentContext, 'validation.passwordValidate');
    }
    return null;
  }

  void changeLoaderStatus(bool isLoading) {
    this.isLoading.value = isLoading;
  }

  void changeInnerLoaderStatus(bool isLoading) {
    isInnerLoading.value = isLoading;
  }

  void showSuccess(String error) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.green,
        snackStyle: SnackStyle.FLOATING,
        message: error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showMessage(String error) {
    Get.showSnackbar(
      GetSnackBar(
        snackStyle: SnackStyle.GROUNDED,
        message: error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showError(String error) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.red,
        snackStyle: SnackStyle.GROUNDED,
        message: error,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
