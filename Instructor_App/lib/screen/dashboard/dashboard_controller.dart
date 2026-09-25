import 'package:get/get.dart';
import 'package:instructor_app/model/dashboard_stats_model.dart';
import 'package:instructor_app/model/user_model.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/services/api_services.dart';

class DashboardController extends BaseController {
  final RxInt selectedTabIndex = 0.obs;
  final Rx<DashboardStatsModel> stats = DashboardStatsModel().obs;
  final Rx<UserModel?> instructor = Rx<UserModel?>(null);

  @override
  void onInitSetup() {
    loadDashboardData();
  }

  void switchTab(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> loadDashboardData() async {
    try {
      changeLoaderStatus(true);
      var fetchedStats = await ApiServices().getDashboardStats();
      var profile = await ApiServices().getProfile();
      stats.value = fetchedStats;
      instructor.value = profile;
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }
}
