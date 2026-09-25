import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/review_item_model.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/services/api_services.dart';

class ReviewsController extends BaseController {
  final RxList<ReviewItemModel> reviews = <ReviewItemModel>[].obs;
  final replyController = TextEditingController();

  @override
  void onInitSetup() {
    loadReviews();
  }

  Future<void> loadReviews({bool showLoader = true}) async {
    try {
      if (showLoader) changeLoaderStatus(true);
      var fetched = await ApiServices().getReviews();
      if (isClosed) return;
      reviews.assignAll(fetched);
      reviews.refresh();
    } catch (e) {
      if (!isClosed) showError(e.toString());
    } finally {
      if (showLoader && !isClosed) changeLoaderStatus(false);
    }
  }

  double get averageRating {
    if (reviews.isEmpty) return 5.0;
    double sum = reviews.fold(0.0, (prev, r) => prev + r.rating);
    return double.parse((sum / reviews.length).toStringAsFixed(1));
  }

  double getStarPercentage(int star) {
    if (reviews.isEmpty) return 0.0;
    int count = reviews.where((r) => r.rating.round() == star).length;
    return count / reviews.length;
  }

  Future<bool> submitReply(int reviewId) async {
    String text = replyController.text.trim();
    if (text.isEmpty) {
      showError("Please enter your reply");
      return false;
    }

    try {
      changeInnerLoaderStatus(true);
      bool ok = await ApiServices().replyReview(reviewId, text);
      if (isClosed) return false;
      if (ok) {
        replyController.clear();
        await loadReviews(showLoader: false);
        return true;
      }
      return false;
    } catch (e) {
      if (!isClosed) showError(e.toString());
      return false;
    } finally {
      if (!isClosed) changeInnerLoaderStatus(false);
    }
  }

  @override
  void onClose() {
    replyController.dispose();
    super.onClose();
  }
}
