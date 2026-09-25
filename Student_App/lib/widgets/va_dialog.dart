import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/search/searchbar_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_button.dart';

class VADialog {
  static void searchDialogPopup(BuildContext context,
      SearchBarController controller, Function()? onApply) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding:
            const EdgeInsets.only(right: 12, left: 15, top: 114, bottom: 80),
        content: Container(
          padding:
              const EdgeInsets.only(right: 12, left: 15, top: 16, bottom: 16),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      controller.resetFilter();
                      onApply?.call();
                      Get.back();
                    },
                    child: Text(
                      'Reset',
                      style: TextStyles().textStyleRoboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1, color: AppColors.settingBorderColor),
              const SizedBox(height: 16),
              Text(
                'Sort by:',
                style: TextStyles().textStyleRoboto(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.settingBorderColor),
                ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text(
                        'Default',
                        style: TextStyle(fontSize: 14),
                      ),
                      isDense: true,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.black,
                        size: 20,
                      ),
                      items: controller.optionsS.map<DropdownMenuItem<String>>(
                        (options) {
                          return DropdownMenuItem<String>(
                            value: options,
                            child: Text(
                              options,
                              style: TextStyles().textStyle14Roboto(),
                            ),
                          );
                        },
                      ).toList(),
                      value: controller.selectedOptions.value,
                      onChanged: (String? newValue) {
                        controller.selectedOptions.value = newValue ?? '';
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Subcategory',
                style: TextStyles().textStyleRoboto(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 200, minHeight: 56.0),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 2),
                  itemCount: controller.subCategoryList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                width: 1.0,
                                color: AppColors.dropShadow,
                              ),
                            ),
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -1),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: controller
                                .subCategoryList[index].isSelected?.value,
                            onChanged: (bool? value) {
                              controller.toggleCheckbox(index);
                            },
                            activeColor: AppColors.primaryColor,
                            checkColor: AppColors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          controller.subCategoryList[index].name ?? '',
                          style: TextStyles().textStyleRoboto(fontSize: 14),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              VAButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  onApply?.call();
                  Get.back();
                },
                text:
                    translate(MyGlobals.navKey.currentContext, 'common.apply'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  static void closeAccountDialog(BuildContext context, Function() onTap) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding:
            const EdgeInsets.only(right: 12, left: 15, top: 114, bottom: 80),
        content: Container(
          padding:
              const EdgeInsets.only(right: 12, left: 15, top: 16, bottom: 16),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Close account',
                style: TextStyles().textStyleRoboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 2,
              ),
              const SizedBox(height: 20),
              Text(
                'Are you sure you want to close account ?',
                style: TextStyles().textStyleRoboto(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 49),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      onTap.call();
                      Get.back();
                    },
                    child: Text(
                      'Yes',
                      style: TextStyles().textStyleRoboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyles().textStyleRoboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void openImageDialog(
    BuildContext context, {
    Function()? onImagePick,
    Function()? onCameraPick,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Wrap(
          children: [
            Center(
              child: Container(
                color: AppColors.white,
                padding: const EdgeInsets.only(
                    right: 12, left: 15, top: 16, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        onCameraPick?.call();
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppColors.primaryColor,
                        size: 60,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        onImagePick?.call();
                      },
                      child: const Icon(
                        Icons.image_rounded,
                        color: AppColors.primaryColor,
                        size: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
