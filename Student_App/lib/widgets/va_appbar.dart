import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_back_button.dart';

class VAAppBar extends StatefulWidget {
  const VAAppBar({
    required this.appBarTitle,
    this.onBackPressed,
    this.isWishListIcon = false,
    this.isHideBack = false,
    super.key,
  });

  final String appBarTitle;
  final void Function()? onBackPressed;
  final bool isWishListIcon;
  final bool isHideBack;

  @override
  State<VAAppBar> createState() => _VAAppBarState();
}

class _VAAppBarState extends State<VAAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!widget.isHideBack) ...[
            VABackButton(
              onPressed: widget.onBackPressed,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              widget.appBarTitle,
              style: TextStyles().textStyleRoboto(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          widget.isWishListIcon
              ? Container(
                  padding: EdgeInsets.zero,
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.bookMarkTitleColor,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (widget.onBackPressed != null) {
                        widget.onBackPressed!();
                      }
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.favorite_rounded,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
