import 'package:flutter/material.dart';
import 'package:skillora/utilities/app_colors.dart';

class TextStyles {
  TextStyle textStyleRoboto({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      letterSpacing: letterSpacing,
    );
  }

  TextStyle textStyle14Roboto({
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: 14,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  TextStyle textStyle16Roboto({
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: 16,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  TextStyle textStyle18Roboto({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: 18,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  TextStyle get textStyle16Black => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      );
  TextStyle get textStyle16White => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  TextStyle get textStyle14Black => const TextStyle(
        fontSize: 14,
        color: AppColors.black,
      );
  TextStyle get textStyle14White => const TextStyle(
        fontSize: 14,
        color: AppColors.white,
      );

  TextStyle get textStyle16RobotoWhite => const TextStyle(
        fontFamily: "Roboto",
        fontSize: 16,
        color: AppColors.white,
      );
}
