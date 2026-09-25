import 'package:flutter/material.dart';
import 'package:instructor_app/utilities/app_colors.dart';

class TextStyles {
  TextStyle textStyleRoboto({
    double? fontSize,
    Color? color = AppColors.black,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  TextStyle textStyle14Roboto({
    Color? color = AppColors.black,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: 14,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      height: height,
    );
  }

  TextStyle textStyle16Roboto({
    Color? color = AppColors.black,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: 16,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      height: height,
    );
  }

  TextStyle textStyle18Roboto({
    double? fontSize,
    Color? color = AppColors.black,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: fontSize ?? 18,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      height: height,
    );
  }
}
