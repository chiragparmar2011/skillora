import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

class VAProfileOptionWidget extends StatelessWidget {
  const VAProfileOptionWidget({
    this.optionName,
    this.onPressed,
    required this.isSwitchVisible,
    required this.switchValue,
    super.key,
  });

  final String? optionName;
  final VoidCallback? onPressed;
  final bool isSwitchVisible;
  final RxBool switchValue;

  void toggleSwitch(bool value) {
    switchValue.value = !switchValue.value;
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.settingBorderColor),
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                optionName ?? '',
                style: TextStyles().textStyleRoboto(
                  fontSize: 16,
                ),
              ),
              !isSwitchVisible
                  ? const Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 16,
                    )
                  : Container(
                      constraints: const BoxConstraints(maxHeight: 20),
                      child: Transform.scale(
                        scale: 1,
                        child: Obx(
                          () => Switch(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: toggleSwitch,
                            value: switchValue.value,
                            activeThumbColor: AppColors.white,
                            activeTrackColor: AppColors.primaryColor,
                            inactiveThumbColor: AppColors.white,
                            inactiveTrackColor: AppColors.black,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
