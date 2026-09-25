import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/model/user_model.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/translation/language_model.dart';
import 'package:skillora/translation/local_constant.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/assets_path.dart';
import 'package:skillora/widgets/va_default_dialog.dart';

class ProfileController extends BaseController with ConnectivityMixin {
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> contactNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> languageTextController =
      TextEditingController().obs;
  RxBool isLoader = false.obs;
  RxString profileImage = ''.obs;

  RxString selectedLanguage = 'English'.obs;
  RxString selectedLanguageCode = 'en'.obs;
  List<LanguageModel> languages = [
    LanguageModel(languageName: 'English', languageCode: 'en'),
    LanguageModel(languageName: 'हिन्दी (Hindi)', languageCode: 'hi'),
    LanguageModel(languageName: 'ગુજરાતી (Gujarati)', languageCode: 'gu'),
    LanguageModel(languageName: 'Italiano (Italian)', languageCode: 'it'),
    LanguageModel(languageName: '中文 (Chinese)', languageCode: 'zh'),
  ];
  Rx<UserModel> user = UserModel().obs;
  final ImagePicker picker = ImagePicker();

  @override
  void onClose() {
    firstNameController.value.clear();
    lastNameController.value.clear();
    contactNumberController.value.clear();
    addressController.value.clear();
    emailController.value.clear();
    super.onClose();
  }

  void updateProfile() async {
    try {
      changeLoaderStatus(true);
      Map<String, dynamic> data = {
        'first_name': firstNameController.value.text.trim(),
        'last_name': lastNameController.value.text.trim(),
        'phone': contactNumberController.value.text.trim(),
        'address': addressController.value.text.trim(),
        'email': emailController.value.text.trim(),
      };
      user.value = await apiServices.updateUser(data) ?? UserModel();
      SharedPreferenceHelper.setUser(user.value);
      showMessage(translate(MyGlobals.navKey.currentContext, 'profile.saved'));
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  @override
  onInitSetup() {
    setUserData();
  }

  String getProfileImage() {
    if (isDemoUser()) {
      return AssetsPath.logoWhite;
    }
    return user.value.image ?? '';
  }

  void setUserData() {
    user.value = SharedPreferenceHelper.getUser() ?? UserModel();

    firstNameController.value.text = user.value.firstName ?? '';
    lastNameController.value.text = user.value.lastName ?? '';
    contactNumberController.value.text = user.value.phone ?? '';
    addressController.value.text = user.value.address ?? '';
    emailController.value.text = user.value.email ?? '';
    profileImage.value = user.value.image ?? '';

    String savedLang = SharedPreferenceHelper.getLanguage();
    if (savedLang.isEmpty) savedLang = 'en';
    selectedLanguageCode.value = savedLang;
    var match = languages.firstWhereOrNull((l) => l.languageCode == savedLang);
    selectedLanguage.value = match?.languageName ?? 'English';
  }

  void closeAccount() async {
    try {
      changeLoaderStatus(true);
      UserModel? userModel = await apiServices.closeAccount();
      if (userModel != null) {
        SharedPreferenceHelper.logout();
        navigateToRemoveStack(RoutePath.signIn);
      }
    } catch (e) {
      showError(e.toString());
    }
    changeLoaderStatus(false);
  }

  void changePushNotification() async {
    try {
      Map<String, dynamic> data = {
        'notification': getPushNotificationValue() ? '2' : '1',
      };

      String? notification = await apiServices.changePushNotification(data);
      user.value.settingModel?.notification = notification ?? '1';
      SharedPreferenceHelper.setUser(user.value);
    } catch (e) {
      showError(e.toString());
    }
  }

  void goToChangePassword() {
    navigateTo(RoutePath.changePassword);
  }

  void pickPhoto({bool isCamera = false}) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    if (statuses[Permission.camera] == PermissionStatus.granted &&
        statuses[Permission.storage] == PermissionStatus.granted) {
      final XFile? image = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (image != null) {
        try {
          UserModel? userData = await apiServices.updateProfile(image.path);
          user.value = userData ?? UserModel();
          user.value.image = userData?.image ?? '';
          profileImage.value = userData?.image ?? '';
          SharedPreferenceHelper.setUser(user.value);
          showSuccess(translate(
              MyGlobals.navKey.currentContext, 'profile.profilePhotoUploaded'));
        } catch (e) {
          showError(e.toString());
        }
      }
    } else {
      showError(
          translate(MyGlobals.navKey.currentContext, 'error.permissionError'));
    }
    changeLoaderStatus(false);
  }

  bool getPushNotificationValue() {
    if (user.value.settingModel != null) {
      if (user.value.settingModel?.notification == '1') {
        return true;
      }
    }
    return false;
  }

  void setLanguage() async {
    await changeLanguage(selectedLanguageCode.value);
  }

  void logout() {
    if (isDemoUser()) {
      SharedPreferenceHelper.logout();
      navigateToRemoveStack(RoutePath.signIn);
    } else {
      VADefaultDialog.showLogoutConfirmationDialog(
        () {
          SharedPreferenceHelper.logout();
          navigateToRemoveStack(RoutePath.signIn);
        },
      );
    }
  }
}
