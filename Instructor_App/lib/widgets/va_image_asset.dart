import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instructor_app/utilities/app_colors.dart';

class VAImageAsset extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final double borderRadius;

  const VAImageAsset({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (image.trim().isEmpty) {
      imageWidget = _placeholder();
    } else if (image.endsWith('.svg')) {
      imageWidget = SvgPicture.asset(
        image,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    } else if (image.startsWith('http://') || image.startsWith('https://')) {
      imageWidget = Image.network(
        image,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: AppColors.secondaryColor,
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
      );
    } else if (!kIsWeb && !image.startsWith('assets/') && File(image).existsSync()) {
      imageWidget = Image.file(
        File(image),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    } else {
      imageWidget = Image.asset(
        image,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }

    if (borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: borderRadius > 0 ? BorderRadius.circular(borderRadius) : null,
      ),
      child: Center(
        child: Icon(
          Icons.person_rounded,
          color: AppColors.primaryColor.withValues(alpha: 0.35),
          size: (height != null && height! < 32) ? 16 : 22,
        ),
      ),
    );
  }
}
