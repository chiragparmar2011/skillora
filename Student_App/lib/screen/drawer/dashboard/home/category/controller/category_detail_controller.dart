import 'package:get/get.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_detail_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/subcategory_model.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/screen/search/searchbar_controller.dart';
import 'package:skillora/services/api_services.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/utilities/app_constants.dart';

class CategoryDetailController extends BaseController with ConnectivityMixin {
  Rx<CategoryDetailModel?> categoryDetail = CategoryDetailModel().obs;
  SearchBarController searchController =
      Get.put(SearchBarController(), tag: 'category_detail_search');

  @override
  onInitSetup() {
    searchController.clearSearch();
    var argument = Get.arguments;
    if (argument != null && argument.containsKey(AppConstants.categoryId)) {
      int categoryId = argument[AppConstants.categoryId];
      getCategoryDetail(categoryId);
    }
  }

  @override
  void onClose() {
    searchController.clearSearch();
    super.onClose();
    onDelete();
  }

  void getCategoryDetail(int categoryId) async {
    try {
      changeLoaderStatus(true);
      categoryDetail.value = await ApiServices().getCategoryDetail(categoryId);
    } catch (e) {
      e.toString();
    }
    changeLoaderStatus(false);
  }

  void openPopularCourse() {
    navigateTo(RoutePath.popularCourse, data: {
      AppConstants.isPopular: true,
    });
  }

  void openCourseDetail(CourseModel? course) {
    navigateTo(
      RoutePath.courseDetail,
      data: {
        "courseId": course?.id,
      },
    );
  }

  List<InstructorModel> getPopularInstructor() {
    return categoryDetail.value?.popularInstructor ?? [];
  }

  List<PopularTopics> getPopularTopics() {
    return categoryDetail.value?.popularTopics ?? [];
  }

  List<SubCategoryModel> getSubCategories() {
    return categoryDetail.value?.subcategory ?? [];
  }

  List<CourseModel> getPopularCourseList() {
    return categoryDetail.value?.popularCourse ?? [];
  }

  void openInstructor() {
    navigateTo(
      RoutePath.instructor,
      data: {
        AppConstants.isPopular: true,
      },
    );
  }

  void openInstructorDetail(InstructorModel? instructor) {
    navigateTo(
      RoutePath.instructorDetail,
      data: {
        "instructorId": instructor?.id,
      },
    );
  }
}
