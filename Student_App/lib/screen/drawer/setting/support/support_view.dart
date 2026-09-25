import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/setting/support/controller/support_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_common_profile.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';
import 'package:skillora/widgets/va_profile_option_widget.dart';
import 'package:skillora/widgets/va_text_field.dart';

class SupportView extends StatelessWidget {
  SupportView({super.key});

  final SupportController controller = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: Obx(() => controller.isInternetConnected
            ? const VANoInternetAsset()
            : _buildMain()),
      ),
    );
  }

  Widget _buildMain() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VAAppBar(
            appBarTitle: translate(
                MyGlobals.navKey.currentContext, 'profile.profileAndSettings'),
          ),
          VACommonProfile(
            profileImage: ((controller.user?.image) ?? '').obs,
            userEmail: controller.user?.email ?? '',
            userName: controller.user?.fullName,
            optionName: translate(
                MyGlobals.navKey.currentContext, 'profile.settings.support'),
          ),
          VaTextField(
            controller: controller.emailController,
            hintText:
                translate(MyGlobals.navKey.currentContext, 'profile.email'),
            isSetting: true,
            enable: false,
          ),
          VaTextField(
            controller: controller.contactNoController,
            hintText: translate(
                MyGlobals.navKey.currentContext, 'profile.contactNumber'),
            isSetting: true,
            enable: false,
          ),
          VAProfileOptionWidget(
            optionName:
                translate(MyGlobals.navKey.currentContext, 'profile.aboutUs'),
            onPressed: () {
              controller.openAbout();
            },
            isSwitchVisible: false,
            switchValue: false.obs,
          ),
          VAProfileOptionWidget(
            optionName:
                translate(MyGlobals.navKey.currentContext, 'profile.shareApp'),
            onPressed: () {
              controller.shareApp();
            },
            isSwitchVisible: false,
            switchValue: false.obs,
          ),
        ],
      ),
    );
  }
}
