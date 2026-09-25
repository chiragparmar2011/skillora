import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/dashboard/profile/profile_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_appbar.dart';
import 'package:instructor_app/widgets/va_button.dart';
import 'package:instructor_app/widgets/va_image_asset.dart';
import 'package:instructor_app/widgets/va_text_form_field.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final ProfileController controller = Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initEditProfile();
    });

    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: VAAppBar(
        title: translate(context, 'profile.editProfile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Avatar with camera edit badge
              Center(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () => _showImagePickerSheet(context),
                          child: Container(
                            width: 104,
                            height: 104,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withValues(alpha: 0.18),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Obx(
                                () => VAImageAsset(
                                  image: controller.selectedAvatar.value.isNotEmpty
                                      ? controller.selectedAvatar.value
                                      : (controller.user.value?.avatar ??
                                          'assets/images/mentor_one.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => _showImagePickerSheet(context),
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: AppColors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => _showImagePickerSheet(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.edit_outlined,
                              size: 14,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              translate(context, 'profile.changePhoto'),
                              style: TextStyles().textStyleRoboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: VATextFormField(
                      controller: controller.firstNameCtrl,
                      labelText: translate(context, 'auth.firstName'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: VATextFormField(
                      controller: controller.lastNameCtrl,
                      labelText: translate(context, 'auth.lastName'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              VATextFormField(
                controller: controller.phoneCtrl,
                labelText: translate(context, 'auth.phone'),
              ),
              const SizedBox(height: 14),
              VATextFormField(
                controller: controller.headlineCtrl,
                labelText: translate(context, 'auth.headline'),
              ),
              const SizedBox(height: 14),
              VATextFormField(
                controller: controller.bioCtrl,
                labelText: translate(context, 'auth.bio'),
                maxLines: 4,
              ),
              const SizedBox(height: 28),
              Obx(
                () => VAButton(
                  text: translate(context, 'common.save'),
                  isLoading: controller.isInnerLoading.value,
                  onPressed: () async {
                    bool ok = await controller.updateProfileDetails();
                    if (ok) Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.platinumBorder,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              translate(context, 'profile.choosePhoto'),
              style: TextStyles().textStyleRoboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Take a picture, choose from gallery, or select an avatar preset",
              style: TextStyles().textStyleRoboto(
                fontSize: 12,
                color: AppColors.mentorAbout,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSourceCard(
                    icon: Icons.camera_alt_rounded,
                    label: translate(context, 'profile.takePhoto'),
                    color: AppColors.primaryColor,
                    onTap: () async {
                      Navigator.pop(ctx);
                      await controller.pickImageFromCamera();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSourceCard(
                    icon: Icons.photo_library_rounded,
                    label: translate(context, 'profile.chooseFromGallery'),
                    color: AppColors.blue,
                    onTap: () async {
                      Navigator.pop(ctx);
                      await controller.pickImageFromGallery();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              translate(context, 'profile.avatarPresets'),
              style: TextStyles().textStyleRoboto(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                'assets/images/mentor_one.png',
                'assets/images/chat_one.png',
                'assets/images/chat_two.png',
                'assets/images/chat_three.png',
              ].map((path) {
                return Obx(() {
                  final isSelected = controller.selectedAvatar.value == path;
                  return GestureDetector(
                    onTap: () {
                      controller.selectAvatarPreset(path);
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.platinumBorder,
                          width: isSelected ? 3 : 1.5,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipOval(
                              child: VAImageAsset(
                                image: path,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_rounded,
                                  color: AppColors.white,
                                  size: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyles().textStyleRoboto(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
