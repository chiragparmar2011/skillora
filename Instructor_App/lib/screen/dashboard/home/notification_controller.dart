import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/notification_item_model.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/screen/dashboard/dashboard_controller.dart';
import 'package:instructor_app/screen/dashboard/earnings/earnings_view.dart';
import 'package:instructor_app/screen/dashboard/home/recent_activity_view.dart';
import 'package:instructor_app/services/api_services.dart';
import 'package:instructor_app/utilities/app_colors.dart';

class NotificationController extends BaseController {
  final RxList<NotificationItemModel> notifications = <NotificationItemModel>[].obs;

  @override
  void onInitSetup() {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      changeLoaderStatus(true);
      var fetched = await ApiServices().getNotifications();
      notifications.assignAll(fetched);
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  Map<String, List<NotificationItemModel>> get groupedNotifications {
    final Map<String, List<NotificationItemModel>> groups = {
      'Today': [],
      'Yesterday': [],
      'Earlier This Week': [],
    };

    for (var item in notifications) {
      if (groups.containsKey(item.dayGroup)) {
        groups[item.dayGroup]!.add(item);
      } else {
        groups.putIfAbsent(item.dayGroup, () => []).add(item);
      }
    }

    return groups;
  }

  void markAllRead() {
    for (var n in notifications) {
      n.isRead = true;
    }
    notifications.refresh();
    ApiServices().markAllNotificationsRead();
  }

  void clearAll() {
    notifications.clear();
    ApiServices().clearAllNotifications();
  }

  void onNotificationTap(BuildContext context, NotificationItemModel notif) {
    if (!notif.isRead) {
      notif.isRead = true;
      notifications.refresh();
      ApiServices().markNotificationAsRead(notif.id);
    }

    // 1. If target is a bottom navigation tab (0: Home, 1: Courses, 2: QA, 3: Reviews, 4: Profile)
    if (notif.targetTabIndex != null) {
      Get.back(); // Close notifications screen
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().switchTab(notif.targetTabIndex!);
      }
      return;
    }

    // 2. If target is a dedicated screen
    if (notif.targetRoute == '/earnings') {
      Get.to(() => EarningsView());
      return;
    }

    if (notif.targetRoute == '/recentActivity') {
      Get.to(() => RecentActivityView());
      return;
    }

    // Default fallback
    Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      message: notif.title,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.black,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }
}
