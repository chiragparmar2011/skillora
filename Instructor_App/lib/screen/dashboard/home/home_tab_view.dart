import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/dashboard/dashboard_controller.dart';
import 'package:instructor_app/screen/dashboard/earnings/earnings_view.dart';
import 'package:instructor_app/screen/dashboard/home/notification_view.dart';
import 'package:instructor_app/screen/dashboard/home/recent_activity_view.dart';
import 'package:instructor_app/screen/dashboard/home/widget/activity_detail_sheet.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/utilities/app_utils.dart';
import 'package:instructor_app/widgets/va_image_asset.dart';

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});

  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.loadDashboardData(),
          color: AppColors.primaryColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 16),
                _buildStatCards(context),
                const SizedBox(height: 16),
                _buildQuickActions(context),
                const SizedBox(height: 18),
                _buildRecentActivity(context),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Obx(() {
      final user = controller.instructor.value;
      return Row(
        children: [
          // Tapping avatar & greeting switches directly to Profile tab (tab 4)
          GestureDetector(
            onTap: () => controller.switchTab(4),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: VAImageAsset(
                      image: user?.avatar ?? 'assets/images/mentor_one.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.switchTab(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${translate(context, 'dashboard.greeting')} ${user?.firstName ?? 'Instructor'} 👋",
                    style: TextStyles().textStyleRoboto(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user?.headline ?? "Course Creator & Mentor",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 12,
                      color: AppColors.mentorAbout,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Notification icon with active unread badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, color: AppColors.black, size: 26),
                onPressed: () => Get.to(() => NotificationView()),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  // 2x2 Stat Cards - Compact, balanced, attractive
  Widget _buildStatCards(BuildContext context) {
    return Obx(() {
      final s = controller.stats.value;
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  icon: Icons.people_outline_rounded,
                  iconColor: AppColors.blue,
                  iconBg: AppColors.blueLight,
                  title: translate(context, 'dashboard.totalStudents'),
                  value: s.totalStudents.toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  icon: Icons.favorite_border_rounded,
                  iconColor: AppColors.red,
                  iconBg: AppColors.red.withValues(alpha: 0.1),
                  title: translate(context, 'dashboard.totalFollowers'),
                  value: s.totalFollowers.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  icon: Icons.star_rounded,
                  iconColor: AppColors.yellowColor,
                  iconBg: AppColors.yellowColor.withValues(alpha: 0.15),
                  title: translate(context, 'dashboard.avgRating'),
                  value: s.avgRating.toStringAsFixed(1),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: AppColors.green,
                  iconBg: AppColors.green.withValues(alpha: 0.15),
                  title: translate(context, 'dashboard.totalRevenue'),
                  value: AppUtils().formatAmount(s.totalRevenue),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildMetricTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 17),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles().textStyleRoboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles().textStyleRoboto(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }

  // Quick Actions - Unified white card container with 8px radius, aligned with screen cards and balanced 4-column layout
  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate(context, 'dashboard.quickActions'),
          style: TextStyles().textStyleRoboto(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildActionItem(
                  icon: Icons.add_circle_outline_rounded,
                  label: translate(context, 'dashboard.createNewCourse'),
                  color: AppColors.primaryColor,
                  onTap: () => controller.switchTab(1),
                ),
              ),
              Expanded(
                child: _buildActionItem(
                  icon: Icons.question_answer_outlined,
                  label: translate(context, 'dashboard.answerQuestions'),
                  color: AppColors.blue,
                  onTap: () => controller.switchTab(2),
                ),
              ),
              Expanded(
                child: _buildActionItem(
                  icon: Icons.rate_review_outlined,
                  label: translate(context, 'dashboard.viewReviews'),
                  color: AppColors.yellowColor,
                  onTap: () => controller.switchTab(3),
                ),
              ),
              Expanded(
                child: _buildActionItem(
                  icon: Icons.monetization_on_outlined,
                  label: translate(context, 'dashboard.viewEarnings'),
                  color: AppColors.green,
                  onTap: () => Get.to(() => EarningsView()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyles().textStyleRoboto(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Obx(() {
      final transactions = controller.stats.value.recentTransactions;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate(context, 'dashboard.recentActivity'),
                style: TextStyles().textStyleRoboto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => RecentActivityView()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Text(
                    translate(context, 'common.viewAll'),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (transactions.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.platinumBorder),
              ),
              child: Center(
                child: Text(
                  translate(context, 'dashboard.noActivity'),
                  style: TextStyles().textStyleRoboto(
                    fontSize: 13,
                    color: AppColors.mentorAbout,
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length > 5 ? 5 : transactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.platinumBorder),
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
                                width: 40,
                                height: 40,
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
                                ],
                              ),
                            ),
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
                                const SizedBox(height: 2),
                                Text(
                                  tx.date,
                                  style: TextStyles().textStyleRoboto(
                                    fontSize: 11,
                                    color: AppColors.mentorAbout,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      );
    });
  }
}