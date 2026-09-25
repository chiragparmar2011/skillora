import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/subcategory_model.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/screen/search/model/recent_search_model.dart';
import 'package:skillora/services/api_services.dart';

class SearchBarController extends BaseController {
  RxString selectedOptions = 'Default'.obs;
  final suggestions = <String>[].obs;
  TextEditingController? searchTextController = TextEditingController();
  final Key? searchKey = null;
  final RxList<SubCategoryModel> subCategoryList = <SubCategoryModel>[].obs;
  final RxList<RecentSearchModel> recentSearchList = <RecentSearchModel>[].obs;
  final RxList<InstructorModel> instructorList = <InstructorModel>[].obs;

  final List<String> optionsS = [
    'Default',
    'ASC',
    'DESC',
  ];

  @override
  onInitSetup() async {
    await getSubCategory();
    await getBestInstructor();
    getRecentSearch();
  }

  Future<void> getSubCategory() async {
    try {
      subCategoryList.value = await ApiServices().getSubCategory() ?? [];
      subCategoryList.refresh();
    } catch (e) {
      e.toString();
    }
  }

  Future<void> getBestInstructor() async {
    try {
      instructorList.value = await ApiServices().getBestInstructor();
      instructorList.refresh();
    } catch (e) {
      e.toString();
    }
  }

  Future<void> getRecentSearch() async {
    try {
      recentSearchList.value = await ApiServices().getRecentSearch();
      suggestions.clear();
      suggestions.addAll(recentSearchList
          .map(
            (element) => element.text ?? '',
          )
          .toList());
      recentSearchList.refresh();
    } catch (e) {
      e.toString();
    }
  }

  void toggleCheckbox(int index) {
    subCategoryList[index].isSelected?.value =
        !subCategoryList[index].isSelected!.value;
  }

  String getSearchedText() {
    return searchTextController?.text ?? '';
  }

  String getSelectedSort() {
    String sort = '';
    if (selectedOptions.value == optionsS[1]) {
      return 'asc';
    }

    if (selectedOptions.value == optionsS[2]) {
      return 'desc';
    }
    return sort;
  }

  void resetFilter() {
    selectedOptions = 'Default'.obs;
    for (var element in subCategoryList) {
      element.isSelected = false.obs;
    }
  }

  void clearSearch() {
    searchTextController?.clear();
    resetFilter();
  }
}
