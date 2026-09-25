import 'package:flutter/material.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

//ignore: must_be_immutable
class VaNoDataWidget extends StatelessWidget {
  VaNoDataWidget({
    super.key,
    this.isShowText = true,
    this.message,
  });

  bool isShowText = false;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message ??
              translate(MyGlobals.navKey.currentContext, 'common.noData'),
          style: TextStyles().textStyleRoboto(
            color: AppColors.black,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
