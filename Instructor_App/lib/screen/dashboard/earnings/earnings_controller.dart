import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/payout_model.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/services/api_services.dart';

class EarningsController extends BaseController {
  final RxList<PayoutTransactionModel> transactions =
      <PayoutTransactionModel>[].obs;
  final RxDouble availableBalance = 3840.0.obs;
  final RxDouble lifetimeEarnings = 12450.0.obs;

  final amountController = TextEditingController();
  final selectedMethod = 'Bank Transfer'.obs;

  final List<String> payoutMethods = [
    'Bank Transfer',
    'PayPal',
    'Stripe Direct',
  ];

  @override
  void onInitSetup() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    try {
      changeLoaderStatus(true);
      var fetched = await ApiServices().getTransactions();
      transactions.assignAll(fetched);
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  Future<bool> submitPayoutRequest() async {
    double amt = double.tryParse(amountController.text.trim()) ?? 0.0;
    if (amt <= 0) {
      showError("Please enter a valid payout amount");
      return false;
    }
    if (amt > availableBalance.value) {
      showError("Requested amount exceeds available balance");
      return false;
    }

    try {
      changeInnerLoaderStatus(true);
      bool ok =
          await ApiServices().requestPayout(amt, selectedMethod.value);
      if (ok) {
        availableBalance.value -= amt;
        amountController.clear();
        showSuccess("Payout request for \$${amt.toStringAsFixed(2)} submitted successfully!");
        return true;
      }
      return false;
    } catch (e) {
      showError(e.toString());
      return false;
    } finally {
      changeInnerLoaderStatus(false);
    }
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}
