import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/controller/home_controller.dart';
import 'package:skillora/screen/drawer/dashboard/home/widget/home_category_widget.dart';
import 'package:skillora/screen/drawer/dashboard/home/widget/home_instructor_widget.dart';
import 'package:skillora/screen/drawer/dashboard/home/widget/home_popular_course_widget.dart';
import 'package:skillora/screen/drawer/dashboard/home/widget/home_trending_courses_widget.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/screen/search/searchbar_controller.dart';
import 'package:skillora/screen/search/va_search_bar_common.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  HomeController get controller {
    if (!Get.isRegistered<HomeController>()) {
      return Get.put(HomeController());
    }
    return Get.find<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: Obx(
        () {
          if (controller.isInternetConnected) {
            return const VANoInternetAsset();
          }
          return controller.isLoading.value ? const VALoader() : _buildBody();
        },
      ),
    );
  }

  Widget _buildSearch() {
    return SizedBox(
      height: 60,
      child: InkWell(
        onTap: () {
          controller.openCourse();
        },
        child: AbsorbPointer(
          absorbing: true,
          child: VASearchBarCommon(
            controller: SearchBarController(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSearch(),
            const SizedBox(height: 16),
            HomeCategoryWidget(
              categoryList: controller.categoryList ?? [],
              title: translate(MyGlobals.navKey.currentContext,
                  'drawer.homePage.categories'),
              onSeeAllTap: () {
                controller.openCategories();
              },
              onDetailTap: (int? id) {
                controller.openCategoryDetail(id);
              },
            ),
            const SizedBox(height: 20),
            HomePopularCoursesWidget(
              courseList: controller.popularCourseList ?? [],
              onSeeAllTap: () {
                controller.openPopularCourse();
              },
              onDetailTap: (CourseModel? data) {
                controller.openCourseDetail(data);
              },
            ),
            const SizedBox(height: 20),
            HomeTrendingCoursesWidget(
              courseList: controller.trendingCourseList ?? [],
              onSeeAllTap: () {
                controller.openTrendingCourse();
              },
              onDetailTap: (CourseModel? data) {
                controller.openCourseDetail(data);
              },
            ),
            const SizedBox(height: 20),
            HomeInstructorWidget(
              instructorList: controller.instructorList ?? [],
              title: translate(
                  MyGlobals.navKey.currentContext, 'instructor.bestInstructor'),
              onSeeAllTap: () {
                controller.openInstructor();
              },
              onDetailTap: (InstructorModel? data) {
                controller.openInstructorDetail(data);
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
