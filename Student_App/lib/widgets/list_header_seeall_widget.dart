import 'package:flutter/cupertino.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

class ListHeaderSeeAllWidget extends StatelessWidget {
  const ListHeaderSeeAllWidget({
    this.title,
    this.onTap,
    super.key,
  });

  final String? title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2,bottom: 0,top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? translate(MyGlobals.navKey.currentContext, 'common.title'),
            style: TextStyles().textStyle18Roboto(
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                translate(MyGlobals.navKey.currentContext, 'common.seeAll'),
                style: TextStyles().textStyle14Roboto(
                  color: AppColors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
