import 'package:instructor_app/model/payout_model.dart';

class DashboardStatsModel {
  int totalStudents;
  int totalFollowers;
  int totalCourses;
  double avgRating;
  double totalRevenue;
  double availableBalance;
  List<PayoutTransactionModel> recentTransactions;

  DashboardStatsModel({
    this.totalStudents = 1420,
    this.totalFollowers = 890,
    this.totalCourses = 6,
    this.avgRating = 4.9,
    this.totalRevenue = 12450.00,
    this.availableBalance = 3840.00,
    List<PayoutTransactionModel>? recentTransactions,
  }) : recentTransactions = recentTransactions ?? [];
}
