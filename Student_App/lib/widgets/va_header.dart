import 'package:flutter/material.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

class VAHeader extends StatelessWidget {
  const VAHeader({
    required this.assetImage,
    required this.firstText,
    required this.secondText,
    this.heightOne = 14,
    this.heightTwo = 6,
    this.logoHeight = 110,
    this.fontSize = 16,
    super.key,
  });

  final String assetImage;
  final String firstText;
  final String secondText;
  final double heightOne;
  final double heightTwo;
  final double logoHeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          assetImage,
          height: logoHeight,
          fit: BoxFit.fitHeight,
        ),
        SizedBox(height: heightOne),
        Text(
          firstText,
          textAlign: TextAlign.center,
          style: TextStyles().textStyleRoboto(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (secondText.isNotEmpty) ...[
          SizedBox(height: heightTwo),
          Text(
            secondText,
            textAlign: TextAlign.center,
            style: TextStyles().textStyleRoboto(
              fontSize: fontSize,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ],
    );
  }
}
