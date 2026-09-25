import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/setting/controller/setting_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_common_profile.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';
import 'package:skillora/widgets/va_profile_option_widget.dart';

class VideoSettingView extends StatelessWidget {
  VideoSettingView({super.key});

  final SettingController controller = Get.put(SettingController());

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
            appBarTitle: translate(MyGlobals.navKey.currentContext,
                'profile.settings.videoPreference'),
          ),
          VACommonProfile(
            profileImage: ((controller.user?.image) ?? '').obs,
            userEmail: controller.user?.email ?? '',
            userName: controller.user?.fullName,
            optionName: translate(MyGlobals.navKey.currentContext,
                'profile.settings.videoPreference'),
          ),
          VAProfileOptionWidget(
            optionName: translate(MyGlobals.navKey.currentContext,
                'profile.settings.autoPlayNextLecture'),
            isSwitchVisible: true,
            onPressed: () {
              controller.changAutoPlayLecture();
            },
            switchValue: controller.getAutoPlayLecture().obs,
          ),
        ],
      ),
    );
  }
}
