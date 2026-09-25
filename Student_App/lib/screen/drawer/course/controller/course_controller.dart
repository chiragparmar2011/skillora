import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_model.dart';
import 'package:skillora/screen/drawer/trending/controller/tabbar_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/screen/search/searchbar_controller.dart';
import 'package:skillora/services/api_services.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_constants.dart';

class CourseController extends BaseController with ConnectivityMixin {
  SearchBarController searchController =
      Get.put(SearchBarController(), tag: 'course_search');
  RxList<CourseModel> courseList = <CourseModel>[].obs;
  List<CategoryModel> categoryList = [];
  RxList<String> categoryNameList = <String>[].obs;
  ToggleController tabController = Get.put(
    ToggleController(),
    tag: "categoryTab",
  );
  bool isPopular = false;
  bool isBookmark = false;
  bool isTrending = false;
  bool isPurchase = false;
  String categoryId = '';
  String subCategoryId = '';
  String search = '';

  @override
  onInitSetup() async {
    if (Get.arguments != null) {
      Map<String, dynamic> argument = Get.arguments;

      if (argument.containsKey(AppConstants.isPopular)) {
        isPopular = argument[AppConstants.isPopular] ?? false;
      }

      if (argument.containsKey(AppConstants.isTrending)) {
        isTrending = argument[AppConstants.isTrending] ?? false;
      }

      if (argument.containsKey(AppConstants.purchased)) {
        isPurchase = argument[AppConstants.purchased] ?? false;
      }

      if (argument.containsKey(AppConstants.search) && argument[AppConstants.search] != null) {
        search = argument[AppConstants.search].toString();
        searchController.searchTextController?.text = search;
      } else {
        searchController.clearSearch();
      }

      if (argument.containsKey(AppConstants.categoryId)) {
        categoryId = argument[AppConstants.categoryId] ?? '';
      }

      if (argument.containsKey(AppConstants.subCategoryId)) {
        subCategoryId = argument[AppConstants.subCategoryId] ?? '';
        for (var element in searchController.subCategoryList) {
          if (element.id.toString() == subCategoryId) {
            element.isSelected?.value = true;
          }
        }
      }

      if (argument.containsKey(AppConstants.isBookmark)) {
        isBookmark = argument[AppConstants.isBookmark] ?? isBookmark;
      }
    } else {
      searchController.clearSearch();
    }

    try {
      changeLoaderStatus(true);
      // await getSubCategory();
      await getCategory();
      await getCourseList();
    } catch (e) {
      e.printError();
    } finally {
      changeLoaderStatus(false);
    }
  }

  Future<void> getCategory() async {
    try {
      categoryList = await ApiServices().getAllCategories() ?? [];
      categoryNameList.clear();
      categoryNameList
          .add(translate(MyGlobals.navKey.currentContext, 'common.all'));

      for (int i = 0; i < categoryList.length; i++) {
        categoryNameList.add(categoryList[i].name ?? '');
        if (categoryList[i].id.toString() == categoryId) {
          tabController.selectedIndex.value = i + 1;
        }
      }
      categoryNameList.refresh();
    } catch (e) {
      e.toString();
    }
  }

  Future<void> getCourseList() async {
    try {
      Map<String, dynamic> dataRequest = {};
      if (isPopular) {
        dataRequest.addAll({'is_popular': 1});
      }

      if (isTrending) {
        dataRequest.addAll({'is_trending': 1});
      }

      if (isBookmark) {
        dataRequest.addAll({'is_wishlist': 1});
      }

      if (categoryId.isNotEmpty) {
        dataRequest.addAll({'category_id': categoryId});
      }

      if (isPurchase) {
        dataRequest.addAll({'my_purchase': "1"});
      }

      if (subCategoryId.isNotEmpty) {
        dataRequest.addAll({'subcategory_id': subCategoryId});
      }

      if (searchController.getSearchedText().isNotEmpty) {
        dataRequest.addAll({'search': searchController.getSearchedText()});
        searchController.getRecentSearch();
      }

      if (searchController.getSelectedSort().isNotEmpty) {
        dataRequest.addAll({'sort_by': searchController.getSelectedSort()});
      }
      List<CourseModel> data = [];
      data = await ApiServices().getCourses(dataRequest);

      courseList.assignAll(data);
    } catch (e) {
      e.toString();
    }
  }

  void onTapBookMark(int index) {
    bookmarkCourse(index);
    courseList.refresh();
  }

  void bookmarkCourse(int index) async {
    try {
      Map<String, dynamic> dataRequest = {};
      dataRequest.addAll({
        'course_id': courseList[index].id.toString(),
        'user_type': AppConstants.user,
      });
      bool? data = await ApiServices().bookmarkCourse(dataRequest);

      updateBookmark(index, data);
    } catch (e) {
      e.toString();
    }
  }

  List<CourseModel> getCourses() {
    return courseList;
  }

  List<CategoryModel> getCategories() {
    return categoryList;
  }

  List<String> getCategoryTabList() {
    return categoryNameList;
  }

  void getCategoryWiseCourseList(int index) async {
    if (index == 0) {
      categoryId = '';
    } else {
      categoryId = categoryList[index - 1].id.toString();
    }
    changeInnerLoaderStatus(true);
    await getCourseList();
    changeInnerLoaderStatus(false);
  }

  void openCourse(int index) async {
    var result = await navigateTo(
      RoutePath.courseDetail,
      data: {
        'courseId': getCourses()[index].id,
      },
    );

    if (result != null) {
      for (CourseModel course in courseList) {
        if ((result as CourseModel).id == course.id) {
          course = result;
          break;
        }
      }
      updateBookmark(index, (result as CourseModel).wishlist ?? false);
    }
  }

  void searchAPI() async {
    List<String?> subCategoryList = [];
    for (var element in searchController.subCategoryList) {
      if (element.isSelected?.value ?? false) {
        subCategoryList.add(element.id.toString());
      }
    }

    subCategoryId = subCategoryList.join(',');
    changeInnerLoaderStatus(true);
    await getCourseList();
    changeInnerLoaderStatus(false);
  }

  @override
  void onClose() {
    searchController.clearSearch();
    tabController.selectedIndex.value = 0;
    super.onClose();
  }

  String getResultText() {
    String noResultText = "";
    if (categoryId.isNotEmpty) {
      noResultText = categoryNameList[tabController.selectedIndex.value];
    }
    if (search.isNotEmpty ||
        ((searchController.searchTextController?.text ?? "").isNotEmpty)) {
      noResultText = searchController.searchTextController?.text ?? "";
    }
    return noResultText;
  }

  void updateBookmark(int index, bool data) {
    if (isBookmark) {
      if (data == false) {
        courseList.removeAt(index);
      }
    } else {
      courseList[index].wishlistSet = data;
    }
    courseList.refresh();
  }
}
