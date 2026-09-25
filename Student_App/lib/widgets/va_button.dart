import 'package:flutter/material.dart';
import 'package:skillora/utilities/app_styles.dart';

class VAButton extends StatefulWidget {
  const VAButton(
      {required this.text,
      this.textStyle,
      this.width = double.infinity,
      this.height = 50,
      required this.onPressed,
      this.progressColor = Colors.white,
      required this.backgroundColor,
      this.disabledBackgroundColor,
      this.isLoading = false,
      this.icon,
      this.shape,
      super.key});

  final double height;
  final double width;
  final String text;
  final TextStyle? textStyle;
  final void Function() onPressed;
  final bool isLoading;
  final Color? progressColor;
  final Color backgroundColor;
  final Color? disabledBackgroundColor;
  final IconData? icon;
  final dynamic shape;

  @override
  State<VAButton> createState() => _VAButtonState();
}

class _VAButtonState extends State<VAButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: widget.backgroundColor,
          disabledBackgroundColor: widget.disabledBackgroundColor,
          elevation: 3,
          shape: widget.shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
        ),
        onPressed: widget.isLoading ? null : widget.onPressed,
        child: widget.isLoading ? _buildProgressIndicator() : _buildRow(),
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) _buildIcon(),
        _buildText(),
      ],
    );
  }

  Widget _buildText() {
    return Text(
      widget.text,
      style: widget.textStyle ?? TextStyles().textStyle16RobotoWhite,
    );
  }

  Widget _buildIcon() {
    return Row(
      children: [
        Icon(
          widget.icon,
          size: 24,
          color: Colors.white,
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        color: widget.progressColor,
        strokeWidth: 2,
      ),
    );
  }
}
