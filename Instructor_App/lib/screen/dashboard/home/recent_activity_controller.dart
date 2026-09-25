import 'package:get/get.dart';
import 'package:instructor_app/model/payout_model.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/services/api_services.dart';

class RecentActivityController extends BaseController {
  final RxList<PayoutTransactionModel> allActivities = <PayoutTransactionModel>[].obs;
  final RxString selectedFilter = 'All'.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInitSetup() {
    loadActivities();
  }

  Future<void> loadActivities() async {
    try {
      changeLoaderStatus(true);
      var fetched = await ApiServices().getTransactions();
      allActivities.assignAll(fetched);
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  List<PayoutTransactionModel> get filteredActivities {
    return allActivities.where((item) {
      // Filter by type
      if (selectedFilter.value == 'Enrollments' && item.type != 'enrollment') {
        return false;
      }
      if (selectedFilter.value == 'Payouts' && item.type != 'payout') {
        return false;
      }

      // Search query
      if (searchQuery.value.trim().isNotEmpty) {
        final q = searchQuery.value.toLowerCase();
        final matchStudent = item.studentName.toLowerCase().contains(q);
        final matchCourse = item.courseName.toLowerCase().contains(q);
        final matchId = item.id.toLowerCase().contains(q);
        if (!matchStudent && !matchCourse && !matchId) return false;
      }

      return true;
    }).toList();
  }

  Map<String, List<PayoutTransactionModel>> get groupedActivities {
    final Map<String, List<PayoutTransactionModel>> groups = {
      'Today': [],
      'Yesterday': [],
      'Earlier This Week': [],
    };

    for (var item in filteredActivities) {
      if (groups.containsKey(item.dayGroup)) {
        groups[item.dayGroup]!.add(item);
      } else {
        groups.putIfAbsent(item.dayGroup, () => []).add(item);
      }
    }

    return groups;
  }

  double get totalVolume {
    return filteredActivities.fold(0.0, (sum, item) => sum + item.amount);
  }
}
