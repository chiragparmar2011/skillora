import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/controller/course_controller.dart';
import 'package:skillora/screen/drawer/course/widget/course_widget.dart';
import 'package:skillora/screen/search/va_search_bar_common.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_common_tabbar.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class CourseScreenWidget extends StatelessWidget {
  const CourseScreenWidget({
    this.title,
    this.downloadView = false,
    required this.controller,
    this.onBackPressed,
    this.isHideBack = false,
    this.isHideAppBar = false,
    super.key,
  });

  final CourseController controller;
  final String? title;
  final bool downloadView;
  final VoidCallback? onBackPressed;
  final bool isHideBack;
  final bool isHideAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!downloadView && !isHideAppBar)
              VAAppBar(
                appBarTitle: title ?? '',
                onBackPressed: onBackPressed,
                isHideBack: isHideBack,
              ),
            Obx(
              () => Expanded(
                child: controller.isInternetConnected
                    ? const VANoInternetAsset()
                    : _buildBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value) {
      return const VALoader();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (!downloadView) ...[
            SizedBox(
              height: 60,
              child: VASearchBarCommon(
                controller: controller.searchController,
                onApply: () {
                  controller.searchAPI();
                },
              ),
            ),
            const SizedBox(height: 10),
            _buildTabBar(),
          ],
          const SizedBox(
            height: 10,
          ),
          Obx(() => Expanded(child: _buildCourseList())),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return VACommonTabBar(
      tabName: controller.getCategoryTabList(),
      tabController: controller.tabController,
      onTapTab: (index) {
        controller.getCategoryWiseCourseList(index);
      },
    );
  }

  Widget _buildCourseList() {
    if (controller.isInnerLoading.value) {
      return const Center(child: VALoader());
    }

    if (controller.getCourses().isEmpty) {
      return Column(
        children: [
          if (!downloadView)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: translate(MyGlobals.navKey.currentContext,
                            'course.resultFor'),
                        style: TextStyles().textStyleRoboto(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: '"',
                        style: TextStyles().textStyleRoboto(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: controller.getResultText() == ""
                            ? "All"
                            : controller.getResultText(),
                        style: TextStyles().textStyleRoboto(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '"',
                        style: TextStyles().textStyleRoboto(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '0 ${translate(MyGlobals.navKey.currentContext, 'course.found')}',
                  style: TextStyles().textStyleRoboto(
                    color: AppColors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.inbox_outlined,
                        size: 72,
                        color: AppColors.darkGray,
                      ),
                    ),
                    Text(
                      translate(
                          MyGlobals.navKey.currentContext, 'course.noData'),
                      style: TextStyles().textStyleRoboto(
                          fontSize: 14, color: AppColors.mentorAbout),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: controller.courseList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            controller.openCourse(index);
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 1),
            elevation: 2,
            shadowColor: AppColors.shadowColor.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: CourseWidget(
              courseModel: controller.getCourses()[index],
              onTapBookmark: () {
                controller.onTapBookMark(index);
              },
            ),
          ),
        );
      },
    );
  }
}
