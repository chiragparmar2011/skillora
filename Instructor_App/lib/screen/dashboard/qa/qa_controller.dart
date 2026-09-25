import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/question_answer_model.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/services/api_services.dart';

class QAController extends BaseController {
  final RxList<QuestionItemModel> questions = <QuestionItemModel>[].obs;
  final RxString selectedTab = 'unanswered'.obs; // 'unanswered', 'all'
  final replyController = TextEditingController();

  @override
  void onInitSetup() {
    loadQuestions();
  }

  Future<void> loadQuestions({bool showLoader = true}) async {
    try {
      if (showLoader) changeLoaderStatus(true);
      var fetched = await ApiServices().getQuestions();
      if (isClosed) return;
      questions.assignAll(fetched);
      questions.refresh();
    } catch (e) {
      if (!isClosed) showError(e.toString());
    } finally {
      if (showLoader && !isClosed) changeLoaderStatus(false);
    }
  }

  List<QuestionItemModel> get filteredQuestions {
    if (selectedTab.value == 'unanswered') {
      return questions.where((q) => !q.isAnswered).toList();
    }
    return questions;
  }

  Future<bool> submitAnswer(int questionId) async {
    String text = replyController.text.trim();
    if (text.isEmpty) {
      showError("Please enter your answer");
      return false;
    }

    try {
      changeInnerLoaderStatus(true);
      bool ok = await ApiServices().replyQuestion(questionId, text);
      if (isClosed) return false;
      if (ok) {
        replyController.clear();
        await loadQuestions(showLoader: false);
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
