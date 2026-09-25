import 'package:get/get.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/screen/search/searchbar_controller.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/utilities/app_constants.dart';

class InstructorController extends BaseController with ConnectivityMixin {
  RxList<InstructorModel> instructorList = <InstructorModel>[].obs;
  SearchBarController searchController =
      Get.put(SearchBarController(), tag: 'instructor_search');
  bool isBest = false;
  bool isPopular = false;
  String search = '';
  String instructorId = '';
  @override
  onInitSetup() {
    var args = Get.arguments;
    if (args != null && args is Map) {
      if (args.containsKey(AppConstants.isBest)) {
        isBest = args[AppConstants.isBest] ?? false;
      }

      if (args.containsKey(AppConstants.isPopular)) {
        isPopular = args[AppConstants.isPopular] ?? false;
      }

      if (args.containsKey(AppConstants.search) && args[AppConstants.search] != null) {
        search = args[AppConstants.search].toString();
        searchController.searchTextController?.text = search;
      } else {
        searchController.clearSearch();
      }
    } else {
      searchController.clearSearch();
    }
    fetchInstructor();
  }

  @override
  void onClose() {
    searchController.clearSearch();
    super.onClose();
  }

  Future<void> fetchInstructor({bool showLoader = true}) async {
    try {
      if (showLoader) changeLoaderStatus(true);
      Map<String, dynamic> dataRequest = {};

      if (isBest) {
        dataRequest.addAll({AppConstants.isBest: 1});
      }

      if (isPopular) {
        dataRequest.addAll({AppConstants.isPopular: 1});
      }

      if (searchController.getSearchedText().isNotEmpty) {
        dataRequest
            .addAll({AppConstants.search: searchController.getSearchedText()});
      }

      List<InstructorModel>? data =
          await apiServices.getBestInstructor(data: dataRequest);
      instructorList.assignAll(data);
      if (showLoader) changeLoaderStatus(false);
    } catch (e) {
      if (showLoader) changeLoaderStatus(false);
    }
  }

  void openInstructorDetail(InstructorModel? instructor) {
    navigateTo(
      RoutePath.instructorDetail,
      data: {
        'instructorId': instructor?.id,
      },
    );
  }

  void searchAPI() async {
    await fetchInstructor(showLoader: false);
  }
}
