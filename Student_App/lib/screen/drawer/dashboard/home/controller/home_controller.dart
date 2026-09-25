import 'package:get/get.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/model/home_model.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/utilities/app_constants.dart';

class HomeController extends BaseController with ConnectivityMixin {
  RxList<CategoryModel>? categoryList = <CategoryModel>[].obs;
  RxList<CourseModel>? popularCourseList = <CourseModel>[].obs;
  RxList<CourseModel>? trendingCourseList = <CourseModel>[].obs;
  RxList<InstructorModel>? instructorList = <InstructorModel>[].obs;

  void gotoCourses(String routePath, {String? data}) {
    navigateTo(routePath, data: data);
  }

  @override
  onInitSetup() {
    getHomeData();
  }

  void getHomeData() async {
    try {
      changeLoaderStatus(true);
      HomeModel? homeData = await apiServices.getHomeData();
      if (homeData != null) {
        categoryList?.value = homeData.categoryList ?? [];
        popularCourseList?.value = homeData.popularCourseList ?? [];
        trendingCourseList?.value = homeData.trendingCourseList ?? [];
        instructorList?.value = homeData.instructorList ?? [];

        categoryList?.refresh();
        popularCourseList?.refresh();
        trendingCourseList?.refresh();
        instructorList?.refresh();
      }
    } catch (e) {
      showError(e.toString());
    }
    changeLoaderStatus(false);
  }

  void openPopularCourse() {
    navigateTo(RoutePath.popularCourse, data: {
      AppConstants.isPopular: true,
    });
  }

  void openTrendingCourse() {
    navigateTo(RoutePath.trending, data: {
      AppConstants.isTrending: true,
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

  void openCategories() {
    navigateTo(RoutePath.category);
  }

  void openCategoryDetail(int? id) {
    navigateTo(
      RoutePath.categoryDetail,
      data: {
        AppConstants.categoryId: id,
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

  void openInstructor() {
    navigateTo(
      RoutePath.instructor,
      data: {
        "is_best": true,
      },
    );
  }

  void openCourse() {
    navigateTo(
      RoutePath.course,
      data: {
        AppConstants.purchased: false,
      },
    );
  }
}
