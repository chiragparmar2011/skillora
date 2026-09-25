import 'package:flutter/material.dart';
import 'package:instructor_app/utilities/app_colors.dart';

class VALoader extends StatelessWidget {
  final double size;
  final Color color;

  const VALoader({
    super.key,
    this.size = 36.0,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
