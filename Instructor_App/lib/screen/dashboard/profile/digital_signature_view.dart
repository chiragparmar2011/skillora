import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/dashboard/profile/profile_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_appbar.dart';
import 'package:instructor_app/widgets/va_button.dart';
import 'package:instructor_app/widgets/va_text_form_field.dart';

class DigitalSignatureView extends StatelessWidget {
  DigitalSignatureView({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: VAAppBar(
        title: translate(context, 'profile.digitalSignature'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.goldLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.6), width: 1.5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.workspace_premium_rounded,
                        color: AppColors.goldDark, size: 36),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Verified Student Certificates",
                            style: TextStyles().textStyleRoboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            translate(context, 'profile.signatureDesc'),
                            style: TextStyles().textStyleRoboto(
                              fontSize: 12,
                              color: AppColors.mentorAbout,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Certificate Signature Line",
                style: TextStyles().textStyleRoboto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              VATextFormField(
                controller: controller.signatureController,
                hintText: "e.g., Robert Fox, Lead Mobile Architect",
              ),
              const SizedBox(height: 24),
              Text(
                "Live Certificate Preview",
                style: TextStyles().textStyleRoboto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.platinumBorder),
                ),
                child: Column(
                  children: [
                    const Text(
                      "CERTIFICATE OF COMPLETION",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: AppColors.goldDark,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            // Listen to user changes
                            final sig = controller.user.value?.digitalSignature ??
                                controller.signatureController.text;
                            return Text(
                              sig.isNotEmpty ? sig : "Instructor Signature",
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                            );
                          }),
                          Container(
                            width: 140,
                            height: 1,
                            color: AppColors.darkGray,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                          ),
                          const Text(
                            "Authorized Signature",
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.mentorAbout,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Obx(
                () => VAButton(
                  text: translate(context, 'profile.saveSignature'),
                  isLoading: controller.isInnerLoading.value,
                  onPressed: () async {
                    bool ok = await controller.saveSignature();
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
}
