import 'package:intl/intl.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/utilities/app_constants.dart';

class AppUtils {
  String getDefaultImage() {
    return '';
  }

  Future<void> launchUrl(Uri url) async {
    try {
      await launchUrl(url);
    } catch (e) {
      logger.i(e.toString());
    }
  }

  Future<void> launchWebSite(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      logger.i(e.toString());
    }
  }

  Future<void> launchFacebook(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      logger.i(e.toString());
    }
  }

  Future<void> launchInstagram(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      logger.i(e.toString());
    }
  }

  String formatAmount(var amount) {
    if (amount == null || amount.toString().isEmpty) {
      return "${AppConstants.currencySymbol}0";
    }
    double parsedAmount = 0.0;
    if (amount is double) {
      parsedAmount = amount;
    } else if (amount is num) {
      parsedAmount = amount.toDouble();
    } else {
      String cleanStr = amount.toString().replaceAll(RegExp(r'[^0-9.]'), '');
      parsedAmount = double.tryParse(cleanStr) ?? 0.0;
    }

    final formatter = NumberFormat.currency(
        symbol: AppConstants.currencySymbol,
        decimalDigits: (parsedAmount.truncateToDouble() == parsedAmount) ? 0 : 2);
    return formatter.format(parsedAmount);
  }

  String parseHtmlString(String? htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String parsedString2 = htmlString?.replaceAll(exp, '') ?? "";
    return parsedString2;
  }
}
