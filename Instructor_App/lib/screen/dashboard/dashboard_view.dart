import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/dashboard/courses/course_list_view.dart';
import 'package:instructor_app/screen/dashboard/dashboard_controller.dart';
import 'package:instructor_app/screen/dashboard/home/home_tab_view.dart';
import 'package:instructor_app/screen/dashboard/profile/profile_view.dart';
import 'package:instructor_app/screen/dashboard/qa/qa_view.dart';
import 'package:instructor_app/screen/dashboard/reviews/reviews_view.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final DashboardController controller = Get.put(DashboardController());

  final List<Widget> pages = [
    HomeTabView(),
    CourseListView(),
    QAView(),
    ReviewsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.selectedTabIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              top: BorderSide(color: AppColors.platinumBorder, width: 1.0),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedTabIndex.value,
            onTap: controller.switchTab,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.bottomIconColor,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.dashboard_outlined),
                activeIcon: const Icon(Icons.dashboard_rounded),
                label: translate(context, 'bottomBar.home'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.video_library_outlined),
                activeIcon: const Icon(Icons.video_library_rounded),
                label: translate(context, 'bottomBar.courses'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.question_answer_outlined),
                activeIcon: const Icon(Icons.question_answer_rounded),
                label: translate(context, 'bottomBar.qa'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.star_outline_rounded),
                activeIcon: const Icon(Icons.star_rounded),
                label: translate(context, 'bottomBar.reviews'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline_rounded),
                activeIcon: const Icon(Icons.person_rounded),
                label: translate(context, 'bottomBar.profile'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
