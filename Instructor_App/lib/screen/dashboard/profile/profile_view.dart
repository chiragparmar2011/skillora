import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/helper/shared_preference_helper.dart';
import 'package:instructor_app/screen/dashboard/profile/digital_signature_view.dart';
import 'package:instructor_app/screen/dashboard/profile/edit_profile_view.dart';
import 'package:instructor_app/screen/dashboard/profile/profile_controller.dart';
import 'package:instructor_app/translation/local_constant.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_image_asset.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          translate(context, 'profile.title'),
          style: TextStyles().textStyleRoboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.platinumBorder, height: 1.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _buildProfileCard(context),
              const SizedBox(height: 20),
              _buildMenuSection(context),
              const SizedBox(height: 24),
              _buildLogoutButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Obx(() {
      final user = controller.user.value;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.platinumBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.to(() => EditProfileView()),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),
                child: ClipOval(
                  child: VAImageAsset(
                    image: user?.avatar ?? 'assets/images/mentor_one.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.fullName ?? "Instructor",
                    style: TextStyles().textStyleRoboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user?.headline ?? "Course Creator",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 12,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user?.email ?? '',
                    style: TextStyles().textStyleRoboto(
                      fontSize: 11,
                      color: AppColors.mentorAbout,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined,
                  size: 20, color: AppColors.black),
              onPressed: () => Get.to(() => EditProfileView()),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.draw_rounded,
            iconColor: AppColors.goldDark,
            title: translate(context, 'profile.digitalSignature'),
            subtitle: "Stamps onto students' certificates",
            onTap: () => Get.to(() => DigitalSignatureView()),
          ),
          const Divider(height: 1, color: AppColors.platinumBorder),
          _buildMenuItem(
            icon: Icons.language_rounded,
            iconColor: AppColors.blue,
            title: translate(context, 'profile.language'),
            subtitle: "Change application language",
            onTap: () => _showLanguageModal(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyles().textStyleRoboto(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyles().textStyleRoboto(
                fontSize: 11,
                color: AppColors.mentorAbout,
              ),
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 14, color: AppColors.mentorAbout),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
      ),
      child: ListTile(
        onTap: () => _confirmLogout(context),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.logout_rounded, color: AppColors.red, size: 20),
        ),
        title: Text(
          translate(context, 'profile.logout'),
          style: TextStyles().textStyleRoboto(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.red,
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          translate(context, 'profile.logout'),
          style: TextStyles().textStyleRoboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(translate(context, 'profile.confirmLogout')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(translate(context, 'common.cancel')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              controller.logout();
            },
            child: Text(
              translate(context, 'profile.logout'),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translate(context, 'profile.language'),
              style: TextStyles().textStyleRoboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildLangTile(ctx, "English", "en"),
            _buildLangTile(ctx, "हिन्दी (Hindi)", "hi"),
            _buildLangTile(ctx, "ગુજરાતી (Gujarati)", "gu"),
            _buildLangTile(ctx, "Italiano (Italian)", "it"),
            _buildLangTile(ctx, "中文 (Chinese)", "zh"),
          ],
        ),
      ),
    );
  }

  Widget _buildLangTile(BuildContext ctx, String label, String code) {
    String current = SharedPreferenceHelper.getLanguage();
    if (current.isEmpty) current = 'en';
    bool isSelected = current == code;

    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppColors.primaryColor : AppColors.black,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_rounded, color: AppColors.primaryColor)
          : null,
      onTap: () async {
        Navigator.pop(ctx);
        await changeLanguage(code);
      },
    );
  }
}
