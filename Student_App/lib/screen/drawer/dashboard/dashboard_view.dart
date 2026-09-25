import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/bookmark/bookmark_view.dart';
import 'package:skillora/screen/drawer/course/controller/course_controller.dart';
import 'package:skillora/screen/drawer/dashboard/controller/dashboard_controller.dart';
import 'package:skillora/screen/drawer/dashboard/home/home_view.dart';
import 'package:skillora/screen/drawer/dashboard/video/video_view.dart';
import 'package:skillora/screen/drawer/setting/profile/profile_view.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({
    super.key,
  });

  @override
  DashboardController get controller {
    if (!Get.isRegistered<DashboardController>()) {
      return Get.put(DashboardController());
    }
    return Get.find<DashboardController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: getScreen(),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.dropShadowColor,
                spreadRadius: 0,
                blurRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: BottomNavigationBar(
              backgroundColor: AppColors.bgColorWhite,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyles().textStyleRoboto(
                fontSize: 12,
              ),
              unselectedLabelStyle: TextStyles().textStyleRoboto(
                fontSize: 12,
              ),
              items: [
                BottomNavigationBarItem(
                  activeIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.home, size: 24),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.home_outlined, size: 24),
                  ),
                  label:
                      translate(MyGlobals.navKey.currentContext, 'drawer.home'),
                ),
                BottomNavigationBarItem(
                  activeIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.play_circle_fill_rounded, size: 24),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.play_circle_outline_rounded, size: 24),
                  ),
                  label: translate(
                      MyGlobals.navKey.currentContext, 'drawer.bottom.video'),
                ),
                BottomNavigationBarItem(
                  activeIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.bookmark_rounded, size: 24),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.bookmark_outline_rounded, size: 24),
                  ),
                  label: translate(MyGlobals.navKey.currentContext,
                      'drawer.bottom.bookmark'),
                ),
                BottomNavigationBarItem(
                  activeIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.person_rounded, size: 24),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.person_outline_rounded, size: 24),
                  ),
                  label: translate(
                      MyGlobals.navKey.currentContext, 'profile.profile'),
                ),
              ],
              currentIndex: controller.selectedIndex.value,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.bottomIconColor,
              onTap: (index) {
                controller.selectedIndex.value = index;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getScreen() {
    if (controller.selectedIndex.value == 0) {
      return const HomeView();
    }
    if (controller.selectedIndex.value == 1) {
      Get.put(CourseController(), tag: RoutePath.video).isPurchase = true;
      Get.put(CourseController(), tag: RoutePath.video).onInitSetup();
      return const VideoView();
    }
    if (controller.selectedIndex.value == 2) {
      return const BookmarkView(
        isHideBack: true,
        isHideAppBar: true,
      );
    }
    if (controller.selectedIndex.value == 3) {
      return ProfileView(
        isHideBack: true,
        isHideAppBar: true,
      );
    }
    return const HomeView();
  }
}
