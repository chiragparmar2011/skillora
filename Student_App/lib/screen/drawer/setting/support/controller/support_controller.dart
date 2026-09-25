import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/model/user_model.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';

class SupportController extends BaseController with ConnectivityMixin {
  final emailController = TextEditingController();
  final contactNoController = TextEditingController();
  UserModel? user;

  @override
  void onClose() {
    emailController.dispose();
    contactNoController.dispose();
    super.onClose();
  }

  @override
  onInitSetup() {
    fetchUserData();
  }

  void fetchUserData() {
    user = SharedPreferenceHelper.getUser();
    emailController.text = 'support@gmail.com';
    contactNoController.text = '+91-1234567890';
  }

  void openAbout() async {
    final Uri url = Uri.parse('https://flutter.dev');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> shareApp() async {
    // Set the app link and the message to be shared
    const String appLink =
        'https://play.google.com/store/apps/details?id=com.skillora';
    const String message = 'Check out my new app: $appLink';

    // Share the app link and message using the share dialog
    await Share.share(message, subject: "Skillora");
  }
}
