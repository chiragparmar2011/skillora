import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/screen/drawer/setting/controller/setting_controller.dart';
import 'package:skillora/translation/local_constant.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_common_profile.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';
import 'package:skillora/widgets/va_profile_option_widget.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  final SettingController controller = Get.put(SettingController());

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
                MyGlobals.navKey.currentContext, 'profile.profileAndSettings'),
            isShowSwitchText: false,
          ),
          VAProfileOptionWidget(
            optionName:
                translate(MyGlobals.navKey.currentContext, 'profile.profile'),
            onPressed: () {
              controller.navigateToProfile();
            },
            isSwitchVisible: false,
            switchValue: false.obs,
          ),
          VAProfileOptionWidget(
            optionName: translate(MyGlobals.navKey.currentContext,
                'profile.settings.videoPreference'),
            onPressed: () {
              controller.navigateToVideoSetting();
            },
            isSwitchVisible: false,
            switchValue: false.obs,
          ),
          VAProfileOptionWidget(
            optionName: translate(MyGlobals.navKey.currentContext,
                'profile.settings.accountSettings'),
            onPressed: () {
              controller.navigateToAccount();
            },
            isSwitchVisible: false,
            switchValue: false.obs,
          ),
          VAProfileOptionWidget(
            optionName: translate(
                MyGlobals.navKey.currentContext, 'profile.languageTitle'),
            onPressed: () {
              _showLanguageModal(context);
            },
            isSwitchVisible: false,
            switchValue: false.obs,
          ),
          VAProfileOptionWidget(
            optionName: translate(
                MyGlobals.navKey.currentContext, 'profile.settings.support'),
            onPressed: () {
              controller.navigateToSupport();
            },
            isSwitchVisible: false,
            switchValue: false.obs,
          ),
        ],
      ),
    );
  }

  void _showLanguageModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translate(context, 'profile.languageTitle'),
              style: TextStyles().textStyleRoboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildLangTile(ctx, "English", "en"),
            _buildLangTile(ctx, "हिन्दी (Hindi)", "hi"),
            _buildLangTile(ctx, "ગુજરાતી (Gujarati)", "gu"),
            _buildLangTile(ctx, "Italiano (Italian)", "it"),
            _buildLangTile(ctx, "中文 (Chinese)", "zh"),
          ],
        ),
      ),
    );
  }

  Widget _buildLangTile(BuildContext ctx, String label, String code) {
    String current = SharedPreferenceHelper.getLanguage();
    if (current.isEmpty) current = 'en';
    bool isSelected = current == code;

    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppColors.primaryColor : AppColors.black,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_rounded, color: AppColors.primaryColor)
          : null,
      onTap: () async {
        Navigator.pop(ctx);
        await changeLanguage(code);
      },
    );
  }
}
