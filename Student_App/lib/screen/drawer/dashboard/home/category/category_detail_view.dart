import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/controller/category_detail_controller.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_detail_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/subcategory_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/widget/home_instructor_widget.dart';
import 'package:skillora/screen/drawer/dashboard/home/widget/home_popular_course_widget.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/screen/search/va_search_bar_common.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/widgets/list_header_seeall_widget.dart';
import 'package:skillora/widgets/stagged_grid_view.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class CategoryDetailView extends StatelessWidget {
  CategoryDetailView({super.key});

  final CategoryDetailController controller = Get.put(
    CategoryDetailController(),
    tag: RoutePath.categoryDetail,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Expanded(
              child: Obx(
                () => controller.isInternetConnected
                    ? const VANoInternetAsset()
                    : _buildBody(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return VAAppBar(
      appBarTitle: translate(
        MyGlobals.navKey.currentContext,
        'drawer.homePage.categories',
      ),
    );
  }

  Widget _buildSearch() {
    return SizedBox(
      height: 60,
      child: VASearchBarCommon(
        controller: controller.searchController,
      ),
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value) {
      return const VALoader();
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildSearch(),
            const SizedBox(height: 10),
            _buildPopularCourses(),
            const SizedBox(height: 10),
            _buildPopularTopic(),
            const SizedBox(height: 10),
            _buildSubcategories(),
            const SizedBox(height: 16),
            _buildPopularInstructor(),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCourses() {
    return controller.getPopularCourseList().isEmpty
        ? Container()
        : HomePopularCoursesWidget(
            courseList: controller.getPopularCourseList(),
            onSeeAllTap: () {
              controller.openPopularCourse();
            },
            onDetailTap: (course) {
              controller.openCourseDetail(course);
            },
          );
  }

  Widget _buildPopularTopic() {
    return controller.getPopularTopics().isEmpty
        ? Container()
        : Column(
            children: [
              ListHeaderSeeAllWidget(
                title: translate(MyGlobals.navKey.currentContext,
                    'drawer.homePage.popularTopics'),
              ),
              const SizedBox(height: 10),
              _buildPopularTopicList(
                list: controller.getPopularTopics(),
                onTap: () {},
              ),
            ],
          );
  }

  Widget _buildSubcategories() {
    return controller.getSubCategories().isEmpty
        ? Container()
        : Column(
            children: [
              ListHeaderSeeAllWidget(
                title: translate(MyGlobals.navKey.currentContext,
                    'drawer.homePage.subCategories'),
              ),
              const SizedBox(height: 10),
              _buildSubCategoryList(
                list: controller.getSubCategories(),
                onTap: () {},
              ),
            ],
          );
  }

  Widget _buildPopularInstructor() {
    return controller.getPopularInstructor().isEmpty
        ? Container()
        : HomeInstructorWidget(
            title: translate(MyGlobals.navKey.currentContext,
                'instructor.popularInstructor'),
            instructorList: controller.getPopularInstructor(),
            onSeeAllTap: () {
              controller.openInstructor();
            },
            onDetailTap: (instructor) {
              controller.openInstructorDetail(instructor);
            },
          );
  }

  Widget _buildPopularTopicList(
      {List<PopularTopics>? list, Function()? onTap}) {
    return SizedBox(
      height: (list?.length ?? 0) >= 2 ? 80 : 40,
      child: StaggeredGridList(
        isTopic: true,
        controller: controller,
        topicList: list,
      ),
    );
  }

  Widget _buildSubCategoryList(
      {List<SubCategoryModel>? list, Function()? onTap}) {
    return SizedBox(
      height: (list?.length ?? 0) >= 2 ? 80 : 40,
      child: StaggeredGridList(
        controller: controller,
        isSubCategory: true,
        subCategoryList: list,
      ),
    );
  }
}
