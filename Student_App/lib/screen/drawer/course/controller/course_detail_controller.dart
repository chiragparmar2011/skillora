import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/course/lesson/model/lesson_model.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/course/model/question_model.dart';
import 'package:skillora/screen/drawer/course/model/review_model.dart';
import 'package:skillora/screen/drawer/trending/controller/tabbar_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/services/api_services.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_constants.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/utilities/app_utils.dart';
import 'package:skillora/widgets/va_button.dart';
import 'package:skillora/widgets/va_image_asset.dart';

class CourseDetailController extends BaseController with ConnectivityMixin {
  var isExpanded = false.obs;
  RxList<LessonsModel> lessonsList = <LessonsModel>[].obs;
  Rx<CourseModel?>? courseDetails = CourseModel().obs;
  final ToggleController tabController = ToggleController();
  final RxList<ReviewModel> reviewsList = <ReviewModel>[].obs;
  final RxBool isReviewsLoading = false.obs;
  final RxList<QuestionModel> questionsList = <QuestionModel>[].obs;
  final RxBool isQuestionsLoading = false.obs;
  final RxSet<int> completedLessonIds = <int>{}.obs;
  final RxDouble courseProgress = 0.0.obs;

  @override
  onInitSetup() {
    // getLessons();
    int courseId = Get.arguments['courseId'] as int;
    getCourseDetail(courseId);
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void getCourseDetail(int courseId) async {
    try {
      changeLoaderStatus(true);
      CourseModel? courseDetailModel =
          await ApiServices().getCourseDetails(courseId);
      courseDetails?.value = courseDetailModel;
      lessonsList.assignAll(courseDetailModel?.lessonList ?? []);
      int cid = courseDetailModel?.id ?? courseId;
      List<String> savedCompleted =
          SharedPreferenceHelper.getCompletedLessons(cid);
      completedLessonIds.clear();
      completedLessonIds.addAll(savedCompleted
          .map((e) => int.tryParse(e) ?? 0)
          .where((id) => id > 0));
      updateProgress();
      getReviews(courseId);
      getQuestions(courseId);
    } catch (e) {
      e.toString();
    }
    changeLoaderStatus(false);
  }

  void updateProgress() {
    final lessons = getLessons();
    if (lessons.isEmpty) {
      courseProgress.value = 0.0;
      return;
    }
    Set<int> validLessonIds =
        lessons.map((l) => l.id ?? 0).where((id) => id > 0).toSet();
    int count =
        completedLessonIds.where((id) => validLessonIds.contains(id)).length;
    double prog = count / lessons.length;
    courseProgress.value = prog.clamp(0.0, 1.0);
  }

  bool isCoursePurchased() {
    return courseDetails?.value?.purchase ?? false;
  }

  bool isLessonDone(int lessonId) {
    return completedLessonIds.contains(lessonId);
  }

  Future<void> toggleLessonDone(int lessonId) async {
    int cid = courseDetails?.value?.id ?? 0;
    if (cid == 0) return;
    bool isNowDone =
        await SharedPreferenceHelper.toggleLessonCompleted(cid, lessonId);
    if (isNowDone) {
      completedLessonIds.add(lessonId);
    } else {
      completedLessonIds.remove(lessonId);
    }
    updateProgress();
    if (courseProgress.value >= 1.0) {
      String msg = translate(
          MyGlobals.navKey.currentContext, 'course.courseCompletedCongrats');
      if (msg.isEmpty) {
        msg =
            "Congratulations! You have completed the course and earned a verified certificate!";
      }
      showSuccess(msg);
    }
  }

  int getCompletedCount() {
    final lessons = getLessons();
    Set<int> validLessonIds =
        lessons.map((l) => l.id ?? 0).where((id) => id > 0).toSet();
    return completedLessonIds.where((id) => validLessonIds.contains(id)).length;
  }

  void getReviews(int courseId) async {
    try {
      isReviewsLoading.value = true;
      List<ReviewModel> fetched =
          await ApiServices().getCourseReviews(courseId);
      reviewsList.value = fetched;
    } catch (e) {
      debugPrint("Error fetching reviews: $e");
    } finally {
      isReviewsLoading.value = false;
    }
  }

  Future<bool> submitReview({
    required double rating,
    required String comment,
  }) async {
    try {
      changeInnerLoaderStatus(true);
      int courseId = courseDetails?.value?.id ?? 0;
      bool success = await ApiServices().addCourseReview(
        courseId: courseId,
        rating: rating,
        comment: comment,
      );
      if (success) {
        getReviews(courseId);
        CourseModel? updated =
            await ApiServices().getCourseDetails(courseId);
        if (updated != null) {
          courseDetails?.value = updated;
          courseDetails?.refresh();
        }
        showSuccess("Your review has been submitted successfully!");
      }
      return success;
    } catch (e) {
      showError(e.toString());
      return false;
    } finally {
      changeInnerLoaderStatus(false);
    }
  }

  void getQuestions(int courseId) async {
    try {
      isQuestionsLoading.value = true;
      List<QuestionModel> fetched =
          await ApiServices().getCourseQuestions(courseId);
      questionsList.value = fetched;
    } catch (e) {
      debugPrint("Error fetching questions: $e");
    } finally {
      isQuestionsLoading.value = false;
    }
  }

  Future<bool> submitQuestion({
    required String title,
    required String description,
    int? lessonId,
    String? lessonName,
  }) async {
    try {
      changeInnerLoaderStatus(true);
      int courseId = courseDetails?.value?.id ?? 0;
      bool success = await ApiServices().addCourseQuestion(
        courseId: courseId,
        title: title,
        description: description,
        lessonId: lessonId,
        lessonName: lessonName,
      );
      if (success) {
        getQuestions(courseId);
        showSuccess("Your question has been posted successfully!");
      }
      return success;
    } catch (e) {
      showError(e.toString());
      return false;
    } finally {
      changeInnerLoaderStatus(false);
    }
  }

  Future<bool> submitAnswer({
    required int questionId,
    required String answerText,
  }) async {
    try {
      changeInnerLoaderStatus(true);
      int courseId = courseDetails?.value?.id ?? 0;
      bool success = await ApiServices().addQuestionAnswer(
        questionId: questionId,
        answerText: answerText,
      );
      if (success) {
        getQuestions(courseId);
        showSuccess("Your reply has been posted!");
      }
      return success;
    } catch (e) {
      showError(e.toString());
      return false;
    } finally {
      changeInnerLoaderStatus(false);
    }
  }

  double getAverageRating() {
    if (reviewsList.isEmpty) {
      return double.tryParse(getRating()) ?? 5.0;
    }
    double total = reviewsList.fold(0.0, (sum, r) => sum + (r.rating ?? 5.0));
    return double.parse((total / reviewsList.length).toStringAsFixed(1));
  }

  int getTotalReviewsCount() {
    return reviewsList.length;
  }

  int getStarCount(int star) {
    return reviewsList.where((r) => (r.rating ?? 0).round() == star).length;
  }

  double getStarPercentage(int star) {
    if (reviewsList.isEmpty) return 0.0;
    int count = getStarCount(star);
    return count / reviewsList.length;
  }

  void onTapBookMark() {
    bookmarkCourse();
  }

  void bookmarkCourse() async {
    try {
      Map<String, dynamic> dataRequest = {};
      dataRequest.addAll({
        'course_id': courseDetails?.value?.id.toString(),
        'user_type': AppConstants.user,
      });
      bool? data = await ApiServices().bookmarkCourse(dataRequest);
      CourseModel? courseModel = courseDetails?.value;
      courseModel?.wishlistSet = data;
      courseDetails?.value = courseModel;
      courseDetails?.refresh();
    } catch (e) {
      e.toString();
    }
  }

  bool getWishList() {
    return courseDetails?.value?.wishlist ?? false;
  }

  String getName() {
    String n = courseDetails?.value?.name ?? '';
    return n.isNotEmpty ? n : 'Course';
  }

  String getInstructorName() {
    String first = courseDetails?.value?.instructor?.firstName ?? '';
    String last = courseDetails?.value?.instructor?.lastName ?? '';
    String full = '$first $last'.trim();
    return full.isNotEmpty ? full : 'Skillora Instructor';
  }

  String getRating() {
    return courseDetails?.value?.rating ?? '';
  }

  String getDuration() {
    return courseDetails?.value?.duration ?? '';
  }

  String getPrice() {
    return courseDetails?.value?.amount ?? '0';
  }

  bool isDiscountAvailable() {
    return courseDetails?.value?.isDiscountAvailable() ?? false;
  }

  String getDiscountPrice() {
    return courseDetails?.value?.discount ?? '0';
  }

  String getPayPrice() {
    String cleanAmt = (courseDetails?.value?.amount ?? "0").replaceAll(RegExp(r'[^0-9.]'), '');
    double amt = double.tryParse(cleanAmt) ?? 0.0;
    return (amt * 100).toInt().toString();
  }

  String getDescription() {
    return courseDetails?.value?.description ?? '';
  }

  bool showReadMore() {
    return (courseDetails?.value?.description ?? '').length > 300;
  }

  List<LessonsModel> getLessons() {
    return courseDetails?.value?.lessonList ?? [];
  }

  String getImage() {
    return courseDetails?.value?.image ?? AppUtils().getDefaultImage();
  }

  RxBool isPaymentLoading = false.obs;

  void consumePurchase(BuildContext context) async {
    if (isDemoUser()) {
      navigateTo(RoutePath.signIn);
      return;
    }

    try {
      isPaymentLoading.value = true;
      var response =
          await createPaymentIntent(getPayPrice(), AppConstants.currencyCode);

      String clientSecret = response['client_secret'] ?? '';
      if (clientSecret.isEmpty) {
        isPaymentLoading.value = false;
        return;
      }
      var gpay = PaymentSheetGooglePay(
        merchantCountryCode: AppConstants.merchantCountryCode,
        currencyCode: AppConstants.currencyCode,
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.light,
          merchantDisplayName: AppConstants.merchantDisplayName,
          googlePay: gpay,
        ),
      );

      isPaymentLoading.value = false;
      if (!context.mounted) return;
      await displayPaymentSheet(context, response);
    } catch (e) {
      isPaymentLoading.value = false;
      debugPrint("Stripe init error: $e");
      if (!context.mounted) return;
      showPaymentBottomSheet(context);
    }
  }

  Future<dynamic> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount.toString(),
        'currency': currency,
      };

      var response = await ApiServices().openPaymentIntent(body);
      return response;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> displayPaymentSheet(BuildContext context, dynamic response) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await purchaseCourse(response);
    } on StripeException catch (e) {
      debugPrint("Stripe payment sheet exception: ${e.error.localizedMessage}");
      if (e.error.code == FailureCode.Canceled) {
        return;
      }
      if (!context.mounted) return;
      showPaymentBottomSheet(context);
    } catch (e) {
      debugPrint("Display Payment sheet error: $e");
      if (!context.mounted) return;
      showPaymentBottomSheet(context);
    }
  }

  void showPaymentBottomSheet(BuildContext context) {
    int selectedPaymentMethod = 0;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method',
                        style: TextStyles().textStyleRoboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: VAImageAsset(
                          image: getImage(),
                          width: 60,
                          height: 60,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getName(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles().textStyleRoboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppUtils().formatAmount(getPrice()),
                              style: TextStyles().textStyleRoboto(
                                fontSize: 16,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Select Payment Option',
                    style: TextStyles().textStyleRoboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGray,
                    ),
                  ),
                  RadioGroup<int>(
                    groupValue: selectedPaymentMethod,
                    onChanged: (val) => setState(() => selectedPaymentMethod = val ?? 0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => selectedPaymentMethod = 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: selectedPaymentMethod == 0
                                  ? AppColors.primaryColor.withValues(alpha: 0.1)
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedPaymentMethod == 0
                                    ? AppColors.primaryColor
                                    : AppColors.platinumBorder,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.credit_card, color: AppColors.primaryColor),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Credit / Debit Card (Stripe)',
                                    style: TextStyles().textStyleRoboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Radio<int>(
                                  value: 0,
                                  activeColor: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => setState(() => selectedPaymentMethod = 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: selectedPaymentMethod == 1
                                  ? AppColors.primaryColor.withValues(alpha: 0.1)
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedPaymentMethod == 1
                                    ? AppColors.primaryColor
                                    : AppColors.platinumBorder,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.account_balance_wallet, color: AppColors.primaryColor),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Google Pay / Apple Pay',
                                    style: TextStyles().textStyleRoboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Radio<int>(
                                  value: 1,
                                  activeColor: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  VAButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () async {
                      Get.back();
                      await purchaseCourse({});
                    },
                    text: 'Pay ${AppUtils().formatAmount(getPrice())}',
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  void openVideoPlayer(LessonsModel? item) {
    navigateTo(
      RoutePath.lessonVideo,
      data: {
        AppConstants.lessonId: item?.id.toString(),
        AppConstants.purchased: courseDetails?.value?.purchase ?? false,
      },
    );
  }

  void openInstructorDetail() {
    navigateTo(
      RoutePath.instructorDetail,
      data: {
        AppConstants.instructorId: courseDetails?.value?.instructor?.id,
      },
    );
  }

  Future<void> purchaseCourse(dynamic responseStripe) async {
    try {
      Map<String, dynamic> data = {
        'amount': getPrice(),
        'payment_response': responseStripe.toString(),
        'course_id': courseDetails?.value?.id.toString() ?? "0",
      };
      String? response = await ApiServices().purchaseCourse(data);
      if (response != null) {
        showSuccess(response);
        courseDetails?.value?.purchaseSet = true;
        courseDetails?.refresh();
        updateProgress();

        /// TODO Need TO Check
        // navigateTo(RoutePath.video);
      }
    } catch (e) {
      showError(e.toString());
    }
  }
}
