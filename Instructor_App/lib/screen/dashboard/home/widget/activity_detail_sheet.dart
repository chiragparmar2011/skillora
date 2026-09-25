import 'package:instructor_app/widgets/va_image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/payout_model.dart';
import 'package:instructor_app/screen/dashboard/dashboard_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/utilities/app_utils.dart';

class ActivityDetailSheet {
  static void show(BuildContext context, PayoutTransactionModel tx) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _ActivityDetailContent(tx: tx),
    );
  }
}

class _ActivityDetailContent extends StatelessWidget {
  final PayoutTransactionModel tx;

  const _ActivityDetailContent({required this.tx});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
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
          const SizedBox(height: 16),

          // Header with Title & Close
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate(context, 'activity.detailsTitle'),
                style: TextStyles().textStyleRoboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, color: AppColors.black),
                onPressed: () => Get.back(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Amount & Status Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.green.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.green.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: VAImageAsset(
                    image: tx.studentAvatar ?? 'assets/images/chat_one.png',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "+${AppUtils().formatAmount(tx.amount)}",
                        style: TextStyles().textStyleRoboto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Course Enrollment Earning",
                        style: TextStyles().textStyleRoboto(
                          fontSize: 12,
                          color: AppColors.mentorAbout,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    translate(context, 'activity.completed'),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Transaction Breakdown Table
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.platinumBorder),
            ),
            child: Column(
              children: [
                _buildRow(
                  label: translate(context, 'activity.transactionId'),
                  valueWidget: InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: tx.id));
                      Get.closeCurrentSnackbar();
                      Get.rawSnackbar(
                        message: translate(context, 'activity.idCopied'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: AppColors.black,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(12),
                        borderRadius: 8,
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tx.id,
                          style: TextStyles().textStyleRoboto(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.copy_rounded,
                          size: 14,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 18, color: AppColors.platinumBorder),
                _buildRow(
                  label: translate(context, 'activity.student'),
                  value: "${tx.studentName}\n(${tx.studentEmail})",
                ),
                const Divider(height: 18, color: AppColors.platinumBorder),
                _buildRow(
                  label: translate(context, 'activity.course'),
                  value: tx.courseName,
                ),
                const Divider(height: 18, color: AppColors.platinumBorder),
                _buildRow(
                  label: translate(context, 'activity.date'),
                  value: "${tx.date} • ${tx.time}",
                ),
                const Divider(height: 18, color: AppColors.platinumBorder),
                _buildRow(
                  label: translate(context, 'activity.paymentMethod'),
                  value: tx.paymentMethod,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Net Revenue Calculation Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.platinumBorder.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate(context, 'activity.grossAmount'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 12,
                        color: AppColors.mentorAbout,
                      ),
                    ),
                    Text(
                      AppUtils().formatAmount(tx.amount),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate(context, 'activity.platformFee'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 12,
                        color: AppColors.mentorAbout,
                      ),
                    ),
                    Text(
                      "-${AppUtils().formatAmount(tx.platformFee)}",
                      style: TextStyles().textStyleRoboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 12, color: AppColors.platinumBorder),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate(context, 'activity.netEarnings'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "+${AppUtils().formatAmount(tx.netEarnings)}",
                      style: TextStyles().textStyleRoboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.platinumBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    translate(context, 'activity.close'),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    if (Get.isRegistered<DashboardController>()) {
                      Get.find<DashboardController>().switchTab(1); // Course Studio tab
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: Text(
                    translate(context, 'activity.viewCourse'),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildRow({
    required String label,
    String? value,
    Widget? valueWidget,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles().textStyleRoboto(
            fontSize: 13,
            color: AppColors.mentorAbout,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: valueWidget ??
              Text(
                value ?? '',
                textAlign: TextAlign.end,
                style: TextStyles().textStyleRoboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
        ),
      ],
    );
  }
}
