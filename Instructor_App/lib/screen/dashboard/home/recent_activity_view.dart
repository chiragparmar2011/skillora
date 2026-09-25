import 'package:instructor_app/widgets/va_image_asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/payout_model.dart';
import 'package:instructor_app/screen/dashboard/home/recent_activity_controller.dart';
import 'package:instructor_app/screen/dashboard/home/widget/activity_detail_sheet.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/utilities/app_utils.dart';

class RecentActivityView extends StatelessWidget {
  RecentActivityView({super.key});

  final RecentActivityController controller = Get.put(RecentActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          translate(context, 'activity.title'),
          style: TextStyles().textStyleRoboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.platinumBorder, height: 1.0),
        ),
      ),
      body: Obx(() {
        final grouped = controller.groupedActivities;
        final totalCount = controller.filteredActivities.length;

        return RefreshIndicator(
          onRefresh: () => controller.loadActivities(),
          color: AppColors.primaryColor,
          child: Column(
            children: [
              // Summary & Search Box
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                child: Column(
                  children: [
                    // Search bar
                    TextField(
                      onChanged: controller.updateSearch,
                      decoration: InputDecoration(
                        hintText: "Search by student, course, or ID...",
                        hintStyle: TextStyles().textStyleRoboto(
                          fontSize: 13,
                          color: AppColors.mentorAbout,
                        ),
                        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.mentorAbout, size: 20),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        filled: true,
                        fillColor: AppColors.platinumBorder.withValues(alpha: 0.25),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Filter chips row
                    Row(
                      children: [
                        _buildFilterChip('All', controller.selectedFilter.value == 'All'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Enrollments', controller.selectedFilter.value == 'Enrollments'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Payouts', controller.selectedFilter.value == 'Payouts'),
                        const Spacer(),
                        Text(
                          "$totalCount Activities",
                          style: TextStyles().textStyleRoboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mentorAbout,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.platinumBorder),

              // Activity List
              Expanded(
                child: totalCount == 0
                    ? _buildEmptyState(context)
                    : ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        children: [
                          for (var entry in grouped.entries)
                            if (entry.value.isNotEmpty) ...[
                              _buildGroupHeader(entry.key, entry.value.length),
                              const SizedBox(height: 8),
                              ...entry.value.map((tx) => _buildActivityItem(context, tx)),
                              const SizedBox(height: 16),
                            ],
                        ],
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.setFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.platinumBorder.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.platinumBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyles().textStyleRoboto(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildGroupHeader(String groupName, int count) {
    return Row(
      children: [
        Text(
          groupName.toUpperCase(),
          style: TextStyles().textStyleRoboto(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: AppColors.mentorAbout,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: AppColors.platinumBorder.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            count.toString(),
            style: TextStyles().textStyleRoboto(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(BuildContext context, PayoutTransactionModel tx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => ActivityDetailSheet.show(context, tx),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: VAImageAsset(
                    image: tx.studentAvatar ?? 'assets/images/chat_one.png',
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${tx.studentName} enrolled in",
                        style: TextStyles().textStyleRoboto(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tx.courseName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles().textStyleRoboto(
                          fontSize: 12,
                          color: AppColors.mentorAbout,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${tx.date} • ${tx.time}",
                        style: TextStyles().textStyleRoboto(
                          fontSize: 11,
                          color: AppColors.mentorAbout,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "+${AppUtils().formatAmount(tx.amount)}",
                      style: TextStyles().textStyleRoboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.mentorAbout,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.platinumBorder.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: AppColors.mentorAbout,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "No Activities Found",
            style: TextStyles().textStyleRoboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "No activity matches your current search or filter.",
            style: TextStyles().textStyleRoboto(
              fontSize: 13,
              color: AppColors.mentorAbout,
            ),
          ),
        ],
      ),
    );
  }
}
