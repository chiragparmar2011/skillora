import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/setting/profile/controller/profile_controller.dart';
import 'package:skillora/translation/language_model.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_button.dart';
import 'package:skillora/widgets/va_common_profile.dart';
import 'package:skillora/widgets/va_dialog.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';
import 'package:skillora/widgets/va_text_field.dart';

class ProfileView extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final bool isHideBack;
  final bool isHideAppBar;
  ProfileView({
    this.onBackPressed,
    this.isHideBack = false,
    this.isHideAppBar = false,
    super.key,
  });

  final ProfileController controller = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: Obx(
          () => controller.isInternetConnected
              ? const VANoInternetAsset()
              : Column(
                  children: [
                    if (!isHideAppBar)
                      VAAppBar(
                        appBarTitle: translate(
                            MyGlobals.navKey.currentContext, 'profile.profile'),
                        onBackPressed: onBackPressed,
                        isHideBack: isHideBack,
                      ),
                    Expanded(child: _buildMain(context)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildMain(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VACommonProfile(
              profileImage: controller.profileImage,
              isVisibleEdit: true,
              onEditPhoto: () {
                VADialog.openImageDialog(
                  context,
                  onImagePick: () {
                    controller.pickPhoto();
                  },
                  onCameraPick: () {
                    controller.pickPhoto(isCamera: true);
                  },
                );
              },
            ),
            VaTextField(
              controller: controller.firstNameController.value,
              headerText: translate(
                  MyGlobals.navKey.currentContext, 'profile.firstName'),
              hintText: translate(
                  MyGlobals.navKey.currentContext, 'profile.firstName'),
              isSetting: true,
            ),
            VaTextField(
              controller: controller.lastNameController.value,
              headerText: translate(
                  MyGlobals.navKey.currentContext, 'profile.lastName'),
              hintText: translate(
                  MyGlobals.navKey.currentContext, 'profile.lastName'),
              isSetting: true,
            ),
            VaTextField(
              controller: controller.contactNumberController.value,
              headerText: translate(
                  MyGlobals.navKey.currentContext, 'profile.contactNumber'),
              hintText: translate(
                  MyGlobals.navKey.currentContext, 'profile.contactNumber'),
              isSetting: true,
            ),
            VaTextField(
              controller: controller.addressController.value,
              headerText:
                  translate(MyGlobals.navKey.currentContext, 'profile.address'),
              hintText:
                  translate(MyGlobals.navKey.currentContext, 'profile.address'),
              isSetting: true,
            ),
            VaTextField(
              enable: false,
              controller: controller.emailController.value,
              headerText:
                  translate(MyGlobals.navKey.currentContext, 'profile.email'),
              hintText:
                  translate(MyGlobals.navKey.currentContext, 'profile.email'),
              isSetting: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate(context, 'profile.languageHeader'),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.platinumBorder,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.platinumBorder),
                    ),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(translate(context, 'profile.languageHeader')),
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: AppColors.black),
                          value: controller.selectedLanguageCode.value,
                          items: controller.languages.map((LanguageModel item) {
                            return DropdownMenuItem<String>(
                              value: item.languageCode ?? '',
                              child: Text(item.languageName ?? ''),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectedLanguageCode.value = newValue;
                              var match = controller.languages.firstWhereOrNull((l) => l.languageCode == newValue);
                              controller.selectedLanguage.value = match?.languageName ?? 'English';
                              controller.setLanguage();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: VAButton(
        isLoading: controller.isLoading.value,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.updateProfile();
          }
        },
        text: translate(MyGlobals.navKey.currentContext, 'common.save'),
      ),
    );
  }
}
