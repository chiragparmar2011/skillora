import 'package:flutter/material.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

//ignore: must_be_immutable
class VaTextField extends StatefulWidget {
  VaTextField({
    required this.controller,
    this.headerText,
    this.hintText,
    this.enable = true,
    this.initialValue,
    this.labelText,
    this.suffixIconButton,
    this.obscureText = false,
    this.validator,
    this.isSetting = false,
    this.readOnly = false,
    this.showHeader = true,
    super.key,
  });

  TextEditingController controller;
  final IconButton? suffixIconButton;
  final String? headerText;
  final String? hintText;
  final String? initialValue;
  final String? labelText;
  final bool obscureText;
  final bool enable;
  final String? Function(String?)? validator;
  final bool isSetting;
  final bool readOnly;
  final bool showHeader;

  @override
  State<VaTextField> createState() => _VaTextFieldState();
}

class _VaTextFieldState extends State<VaTextField> {
  @override
  Widget build(BuildContext context) {
    final title = widget.headerText ??
        widget.labelText ??
        (widget.showHeader ? widget.hintText : null);
    final effectiveHint = widget.hintText;

    final fieldWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null && title.isNotEmpty) ...[
          Text(
            title,
            style: TextStyles().textStyleRoboto(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          enabled: widget.enable,
          initialValue: widget.initialValue,
          readOnly: widget.readOnly,
          controller: widget.controller,
          obscureText: widget.obscureText,
          validator: (widget.validator != null) ? widget.validator : null,
          style: TextStyles().textStyleRoboto(
            fontSize: 14,
            color: widget.enable ? AppColors.black : AppColors.darkGray,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: AppColors.platinumBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: AppColors.platinumBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: AppColors.platinumBorder,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: AppColors.platinumBorder,
              ),
            ),
            counterText: '',
            fillColor: AppColors.platinumBorder,
            filled: true,
            hintText: effectiveHint,
            hintStyle: TextStyles().textStyleRoboto(
              fontSize: 14,
              color: AppColors.darkGray,
            ),
            suffixIcon: widget.suffixIconButton,
          ),
        ),
      ],
    );

    return widget.isSetting
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: fieldWidget,
          )
        : fieldWidget;
  }
}
