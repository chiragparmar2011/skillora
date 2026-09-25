import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/helper/shared_preference_helper.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/screen/routes.dart';
import 'package:instructor_app/services/api_services.dart';

class SignUpController extends BaseController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final headlineController = TextEditingController();
  final bioController = TextEditingController();
  final passwordController = TextEditingController();
  final selectedCategory = 'Mobile Development'.obs;
  final isPasswordHidden = true.obs;

  final List<String> categories = [
    'Mobile Development',
    'Web Development',
    'UI/UX Design',
    'Data Science & AI',
    'Cloud & DevOps',
    'Business & Marketing',
  ];

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> register() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String headline = headlineController.text.trim();
    String bio = bioController.text.trim();
    String password = passwordController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      showError("Please enter your full name");
      return;
    }
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
      var user = await ApiServices().register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        headline: headline.isNotEmpty ? headline : "Expert Instructor",
        bio: bio.isNotEmpty ? bio : "Instructor on Skillora.",
        category: selectedCategory.value,
        password: password,
      );

      if (user != null) {
        await SharedPreferenceHelper.setAuthToken(user.token ?? 'valid_token');
        await SharedPreferenceHelper.setInstructorInfo(user.toJson());
        showSuccess("Registration successful! Welcome to Skillora.");
        navigateTo(RoutePath.dashboard, isClearAll: true);
      }
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  void goToSignIn() {
    Get.back();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    headlineController.dispose();
    bioController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
