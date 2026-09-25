import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instructor_app/helper/shared_preference_helper.dart';
import 'package:instructor_app/model/user_model.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/screen/dashboard/dashboard_controller.dart';
import 'package:instructor_app/screen/routes.dart';
import 'package:instructor_app/services/api_services.dart';

class ProfileController extends BaseController {
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final signatureController = TextEditingController();

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final headlineCtrl = TextEditingController();
  final bioCtrl = TextEditingController();

  final RxString selectedAvatar = ''.obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInitSetup() {
    loadProfile();
  }

  void initEditProfile() {
    if (user.value != null) {
      selectedAvatar.value = user.value?.avatar ?? 'assets/images/mentor_one.png';
      firstNameCtrl.text = user.value?.firstName ?? '';
      lastNameCtrl.text = user.value?.lastName ?? '';
      phoneCtrl.text = user.value?.phone ?? '';
      headlineCtrl.text = user.value?.headline ?? '';
      bioCtrl.text = user.value?.bio ?? '';
    }
  }

  Future<void> loadProfile() async {
    try {
      changeLoaderStatus(true);
      var profile = await ApiServices().getProfile();
      user.value = profile;
      selectedAvatar.value = profile.avatar ?? 'assets/images/mentor_one.png';
      signatureController.text =
          profile.digitalSignature ?? SharedPreferenceHelper.getDigitalSignature();
      if (signatureController.text.isEmpty) {
        signatureController.text = "${profile.fullName}, Lead Instructor";
      }

      firstNameCtrl.text = profile.firstName ?? '';
      lastNameCtrl.text = profile.lastName ?? '';
      phoneCtrl.text = profile.phone ?? '';
      headlineCtrl.text = profile.headline ?? '';
      bioCtrl.text = profile.bio ?? '';
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (photo != null) {
        selectedAvatar.value = photo.path;
      }
    } catch (e) {
      showError("Could not access camera: ${e.toString()}");
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (image != null) {
        selectedAvatar.value = image.path;
      }
    } catch (e) {
      showError("Could not access photo gallery: ${e.toString()}");
    }
  }

  void selectAvatarPreset(String assetPath) {
    selectedAvatar.value = assetPath;
  }

  Future<bool> updateProfileDetails() async {
    if (user.value == null) return false;
    user.value!.firstName = firstNameCtrl.text.trim();
    user.value!.lastName = lastNameCtrl.text.trim();
    user.value!.phone = phoneCtrl.text.trim();
    user.value!.headline = headlineCtrl.text.trim();
    user.value!.bio = bioCtrl.text.trim();
    if (selectedAvatar.value.isNotEmpty) {
      user.value!.avatar = selectedAvatar.value;
    }

    try {
      changeInnerLoaderStatus(true);
      bool ok = await ApiServices().updateProfile(user.value!);
      if (ok) {
        await SharedPreferenceHelper.setInstructorInfo(user.value!.toJson());
        showSuccess("Profile updated successfully!");
        user.refresh();
        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().instructor.value = user.value;
          Get.find<DashboardController>().instructor.refresh();
        }
        return true;
      }
      return false;
    } catch (e) {
      showError(e.toString());
      return false;
    } finally {
      changeInnerLoaderStatus(false);
    }
  }

  Future<bool> saveSignature() async {
    String sig = signatureController.text.trim();
    if (sig.isEmpty) {
      showError("Please enter your signature");
      return false;
    }

    try {
      changeInnerLoaderStatus(true);
      await ApiServices().saveDigitalSignature(sig);
      await SharedPreferenceHelper.setDigitalSignature(sig);
      if (user.value != null) {
        user.value!.digitalSignature = sig;
        user.refresh();
      }
      showSuccess("Digital signature updated for student certificates!");
      return true;
    } catch (e) {
      showError(e.toString());
      return false;
    } finally {
      changeInnerLoaderStatus(false);
    }
  }

  void logout() async {
    await SharedPreferenceHelper.clear();
    navigateTo(RoutePath.signIn, isClearAll: true);
  }

  @override
  void onClose() {
    signatureController.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    headlineCtrl.dispose();
    bioCtrl.dispose();
    super.onClose();
  }
}
