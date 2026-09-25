import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/utilities/app_colors.dart';

class VABackButton extends StatelessWidget {
  const VABackButton({
    this.onPressed,
    this.size = 34,
    super.key,
  });

  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Get.back(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.white,
          size: 15,
        ),
      ),
    );
  }
}
