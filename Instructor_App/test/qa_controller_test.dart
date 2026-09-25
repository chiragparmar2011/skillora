import 'package:flutter_test/flutter_test.dart';
import 'package:instructor_app/screen/dashboard/qa/qa_controller.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  test('QAController loads questions and replies properly', () async {
    final controller = QAController();
    await controller.loadQuestions();

    expect(controller.questions.isNotEmpty, true);
    final initialUnansweredCount = controller.questions.where((q) => !q.isAnswered).length;
    expect(initialUnansweredCount > 0, true);

    // Test submitting answer
    final targetQuestion = controller.questions.firstWhere((q) => !q.isAnswered);
    controller.replyController.text = "This is a verified test instructor answer.";
    final success = await controller.submitAnswer(targetQuestion.id);
    expect(success, true);

    // Verify it is now answered and contains the answer
    final updatedQuestion = controller.questions.firstWhere((q) => q.id == targetQuestion.id);
    expect(updatedQuestion.isAnswered, true);
    expect(updatedQuestion.answers.any((a) => a.answer == "This is a verified test instructor answer."), true);

    // Test submitting a second answer to the same question (Issue 2)
    controller.replyController.text = "Second follow-up answer.";
    final secondSuccess = await controller.submitAnswer(targetQuestion.id);
    expect(secondSuccess, true);

    final multiAnswerQuestion = controller.questions.firstWhere((q) => q.id == targetQuestion.id);
    expect(multiAnswerQuestion.answers.length >= 2, true);
    expect(multiAnswerQuestion.answers.last.answer, "Second follow-up answer.");
  });
}
