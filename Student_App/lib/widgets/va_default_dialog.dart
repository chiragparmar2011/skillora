import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

class VADefaultDialog {
  static Future<void> showLogoutConfirmationDialog(Function onConfirmed) async {
    return Get.defaultDialog(
      title: translate(MyGlobals.navKey.currentContext, 'profile.logout'),
      titleStyle: TextStyles().textStyleRoboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      middleText:
          translate(MyGlobals.navKey.currentContext, 'profile.logoutPopup'),
      middleTextStyle: TextStyles().textStyle16Black,
      backgroundColor: AppColors.white,
      radius: 10,
      actions: [
        _buildDialogButton(
            translate(MyGlobals.navKey.currentContext, 'common.no'),
            AppColors.darkGray, () {
          Get.back();
        }),
        _buildDialogButton(
            translate(MyGlobals.navKey.currentContext, 'common.yes'),
            AppColors.primaryColor, () {
          Get.back();
          onConfirmed();
        }),
      ],
    );
  }

  static Widget _buildDialogButton(
      String text, Color color, Function onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
        backgroundColor: color,
      ),
      child: Text(text),
    );
  }
}
