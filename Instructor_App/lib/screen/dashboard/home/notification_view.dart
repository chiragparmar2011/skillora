import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/notification_item_model.dart';
import 'package:instructor_app/screen/dashboard/home/notification_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final NotificationController controller = Get.put(NotificationController());

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
          translate(context, 'notifications.title'),
          style: TextStyles().textStyleRoboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: AppColors.black),
            onSelected: (value) {
              if (value == 'read') {
                controller.markAllRead();
              } else if (value == 'clear') {
                controller.clearAll();
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'read',
                child: Row(
                  children: [
                    const Icon(Icons.done_all_rounded, size: 18, color: AppColors.primaryColor),
                    const SizedBox(width: 10),
                    Text(
                      translate(context, 'notifications.markAllRead'),
                      style: TextStyles().textStyleRoboto(fontSize: 13, color: AppColors.black),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.red),
                    const SizedBox(width: 10),
                    Text(
                      translate(context, 'notifications.clearAll'),
                      style: TextStyles().textStyleRoboto(fontSize: 13, color: AppColors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.platinumBorder, height: 1.0),
        ),
      ),
      body: Obx(() {
        final grouped = controller.groupedNotifications;
        final totalCount = controller.notifications.length;

        if (totalCount == 0) {
          return _buildEmptyState(context);
        }

        return RefreshIndicator(
          onRefresh: () => controller.loadNotifications(),
          color: AppColors.primaryColor,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            children: [
              for (var entry in grouped.entries)
                if (entry.value.isNotEmpty) ...[
                  _buildGroupHeader(entry.key, entry.value.length),
                  const SizedBox(height: 8),
                  ...entry.value.map((notif) => _buildNotificationTile(context, notif)),
                  const SizedBox(height: 16),
                ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildGroupHeader(String groupName, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
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
      ),
    );
  }

  Widget _buildNotificationTile(BuildContext context, NotificationItemModel notif) {
    final config = _getNotifConfig(notif.type);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: notif.isRead ? AppColors.white : AppColors.primaryColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: notif.isRead ? AppColors.platinumBorder : AppColors.primaryColor.withValues(alpha: 0.25),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => controller.onNotificationTap(context, notif),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type Icon container
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: config.bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(config.icon, color: config.iconColor, size: 20),
                ),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notif.title,
                              style: TextStyles().textStyleRoboto(
                                fontSize: 13.5,
                                fontWeight: notif.isRead ? FontWeight.w600 : FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          if (!notif.isRead) ...[
                            const SizedBox(width: 6),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notif.message,
                        style: TextStyles().textStyleRoboto(
                          fontSize: 12,
                          color: AppColors.black.withValues(alpha: 0.7),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notif.time,
                        style: TextStyles().textStyleRoboto(
                          fontSize: 11,
                          color: AppColors.mentorAbout,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _NotifConfig _getNotifConfig(String type) {
    switch (type) {
      case 'qa':
        return _NotifConfig(
          icon: Icons.question_answer_rounded,
          iconColor: AppColors.blue,
          bgColor: AppColors.blue.withValues(alpha: 0.12),
        );
      case 'review':
        return _NotifConfig(
          icon: Icons.star_rounded,
          iconColor: AppColors.yellowColor,
          bgColor: AppColors.yellowColor.withValues(alpha: 0.15),
        );
      case 'enrollment':
        return _NotifConfig(
          icon: Icons.school_rounded,
          iconColor: AppColors.green,
          bgColor: AppColors.green.withValues(alpha: 0.12),
        );
      case 'payout':
        return _NotifConfig(
          icon: Icons.account_balance_wallet_rounded,
          iconColor: AppColors.primaryColor,
          bgColor: AppColors.primaryColor.withValues(alpha: 0.12),
        );
      case 'follower':
        return _NotifConfig(
          icon: Icons.favorite_rounded,
          iconColor: AppColors.red,
          bgColor: AppColors.red.withValues(alpha: 0.12),
        );
      case 'certificate':
        return _NotifConfig(
          icon: Icons.card_membership_rounded,
          iconColor: Colors.deepPurple,
          bgColor: Colors.deepPurple.withValues(alpha: 0.12),
        );
      default:
        return _NotifConfig(
          icon: Icons.notifications_rounded,
          iconColor: AppColors.primaryColor,
          bgColor: AppColors.primaryColor.withValues(alpha: 0.12),
        );
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_off_outlined,
              size: 52,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            translate(context, 'notifications.noNotifications'),
            style: TextStyles().textStyleRoboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              translate(context, 'notifications.noNotificationsDesc'),
              textAlign: TextAlign.center,
              style: TextStyles().textStyleRoboto(
                fontSize: 13,
                color: AppColors.mentorAbout,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifConfig {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  _NotifConfig({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });
}
