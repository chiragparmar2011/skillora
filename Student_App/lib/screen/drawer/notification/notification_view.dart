import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/notification/controller/notification_controller.dart';
import 'package:skillora/screen/drawer/notification/model/notification_model.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_data_widget.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Obx(
              () => controller.isInternetConnected
                  ? const Expanded(child: VANoInternetAsset())
                  : Expanded(
                      child: Center(
                        child: _buildBody(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return VAAppBar(
      appBarTitle:
          translate(MyGlobals.navKey.currentContext, 'drawer.notification'),
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value) {
      return const VALoader();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: controller.notificationList.isEmpty
          ? VaNoDataWidget()
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.notificationList.length,
              itemBuilder: (BuildContext context, int index) {
                String date = controller.notificationList.keys.toList()[index];
                List<NotificationModel> notifications =
                    controller.notificationList[date] ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        formatDate(date),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      itemCount: notifications.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0.4,
                          shadowColor: AppColors.bgColorWhite,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                            child: Row(
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryColor.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    notifications[index].title?.toLowerCase().contains('payment') == true
                                        ? Icons.payment_rounded
                                        : notifications[index].title?.toLowerCase().contains('discount') == true
                                            ? Icons.local_offer_outlined
                                            : Icons.notifications_outlined,
                                    color: AppColors.black,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notifications[index].title ?? '',
                                        style: TextStyles().textStyleRoboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        notifications[index].message ?? '',
                                        style: TextStyles().textStyleRoboto(
                                          fontSize: 12,
                                          color: AppColors.searchColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
    );
  }

  String formatDate(String formattedDate) {
    if (formattedDate.trim().toLowerCase() == 'today') {
      return "Today";
    }
    if (formattedDate.trim().toLowerCase() == 'yesterday') {
      return "Yesterday";
    }

    DateTime? dateTime;
    try {
      dateTime = DateFormat('dd-MM-yyyy').parse(formattedDate);
    } catch (_) {
      try {
        dateTime = DateTime.tryParse(formattedDate);
      } catch (_) {}
    }

    if (dateTime == null) {
      return formattedDate;
    }

    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return "Today";
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return "Yesterday";
    } else {
      return DateFormat('MMMM dd, yyyy').format(dateTime);
    }
  }
}
