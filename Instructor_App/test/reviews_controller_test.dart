import 'package:flutter_test/flutter_test.dart';
import 'package:instructor_app/screen/dashboard/reviews/reviews_controller.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  test('ReviewsController loads reviews and replies properly', () async {
    final controller = ReviewsController();
    await controller.loadReviews();

    expect(controller.reviews.isNotEmpty, true);
    final unreplied = controller.reviews.firstWhere((r) => r.instructorReply == null);
    expect(unreplied.instructorReply, isNull);

    controller.replyController.text = "Thanks for the feedback!";
    final ok = await controller.submitReply(unreplied.id);
    expect(ok, true);

    final updated = controller.reviews.firstWhere((r) => r.id == unreplied.id);
    expect(updated.instructorReply, "Thanks for the feedback!");
    expect(updated.replyCreatedAt, isNotNull);
  });
}
