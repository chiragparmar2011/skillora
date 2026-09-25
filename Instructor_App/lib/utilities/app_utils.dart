import 'package:intl/intl.dart';
import 'package:instructor_app/utilities/app_constants.dart';

class AppUtils {
  static final AppUtils _instance = AppUtils._internal();
  factory AppUtils() => _instance;
  AppUtils._internal();

  String formatAmount(dynamic amount) {
    if (amount == null) return '${AppConstants.currencySymbol}0';
    double value = 0.0;
    if (amount is num) {
      value = amount.toDouble();
    } else {
      String clean = amount.toString().replaceAll(RegExp(r'[^0-9.]'), '');
      value = double.tryParse(clean) ?? 0.0;
    }
    return '${AppConstants.currencySymbol}${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2)}';
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      DateTime dt = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (_) {
      return dateStr;
    }
  }

  String formatTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      DateTime dt = DateTime.parse(dateStr);
      return DateFormat('hh:mm a').format(dt);
    } catch (_) {
      return dateStr;
    }
  }

  String getDefaultImage() {
    return 'assets/images/app_logo.png';
  }
}
