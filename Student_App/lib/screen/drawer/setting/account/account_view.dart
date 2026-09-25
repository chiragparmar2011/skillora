import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/setting/profile/controller/profile_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_common_profile.dart';
import 'package:skillora/widgets/va_dialog.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';
import 'package:skillora/widgets/va_profile_option_widget.dart';

class AccountView extends StatelessWidget {
  AccountView({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: Obx(() => controller.isInternetConnected
            ? const VANoInternetAsset()
            : _buildMain(context)),
      ),
    );
  }

  Widget _buildMain(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VAAppBar(
                appBarTitle: translate(MyGlobals.navKey.currentContext,
                    'profile.settings.accountSettings'),
              ),
              VACommonProfile(
                profileImage: ((controller.user.value.image) ?? '').obs,
                userEmail: controller.user.value.email ?? '',
                userName: controller.user.value.fullName,
                optionName: translate(MyGlobals.navKey.currentContext,
                    'profile.settings.accountSettings'),
                isShowSwitchText: false,
              ),
              VAProfileOptionWidget(
                optionName: translate(MyGlobals.navKey.currentContext,
                    'profile.settings.pushNotification'),
                isSwitchVisible: true,
                switchValue: controller.getPushNotificationValue().obs,
                onPressed: () {
                  controller.changePushNotification();
                },
              ),
              VAProfileOptionWidget(
                optionName: translate(MyGlobals.navKey.currentContext,
                    'profile.settings.accountSecurity'),
                onPressed: () {
                  controller.goToChangePassword();
                },
                isSwitchVisible: false,
                switchValue: false.obs,
              ),
              VAProfileOptionWidget(
                optionName: translate(MyGlobals.navKey.currentContext,
                    'profile.settings.closeAccount'),
                onPressed: () {
                  VADialog.closeAccountDialog(context, () {
                    controller.closeAccount();
                  });
                },
                isSwitchVisible: false,
                switchValue: false.obs,
              ),
            ],
          ),
          Visibility(
            visible: controller.isLoading.value,
            child: const Positioned(
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: VALoader(),
            ),
          ),
        ],
      ),
    );
  }
}
