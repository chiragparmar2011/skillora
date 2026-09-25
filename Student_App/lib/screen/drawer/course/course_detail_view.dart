import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/screen/drawer/course/controller/course_detail_controller.dart';
import 'package:skillora/screen/drawer/course/lesson/model/lesson_model.dart';
import 'package:skillora/screen/drawer/course/model/question_model.dart';
import 'package:skillora/screen/drawer/course/model/review_model.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/utilities/app_utils.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_button.dart';
import 'package:skillora/widgets/va_image_asset.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_data_widget.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class CourseDetailView extends StatelessWidget {
  CourseDetailView({super.key});

  final CourseDetailController controller = Get.put(CourseDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: Obx(
          () => controller.isInternetConnected
              ? const VANoInternetAsset()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VAAppBar(
                      appBarTitle: translate(
                          MyGlobals.navKey.currentContext, 'course.details'),
                      isWishListIcon: false,
                      onBackPressed: () {
                        Get.back(result: controller.courseDetails?.value);
                      },
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _buildBody(context),
                    ),
                    _buildButton(context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(
        child: VALoader(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInformationView(context),
          const SizedBox(height: 24),
          _buildTabBar(),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.tabController.selectedIndex.value == 0) {
              return _buildLessonView(context);
            } else if (controller.tabController.selectedIndex.value == 1) {
              return _buildReviewsView(context);
            } else {
              return _buildQAView(context);
            }
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInformationView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: VAImageAsset(
                  image: controller.getImage(),
                  boxFit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              if (controller.isDemoUser() == false)
                Positioned(
                  bottom: -22,
                  right: 12,
                  child: Container(
                    height: 48,
                    width: 48,
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Obx(
                            () => Icon(
                              controller.getWishList()
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_outlined,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                          onPressed: () {
                            controller.onTapBookMark();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            controller.getName(),
            style: TextStyles().textStyleRoboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: translate(
                      MyGlobals.navKey.currentContext, 'course.courseBy'),
                  style: TextStyles().textStyleRoboto(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                ),
                const WidgetSpan(child: SizedBox(width: 4)),
                TextSpan(
                  text: controller.getInstructorName(),
                  style: TextStyles().textStyleRoboto(
                    color: AppColors.primaryColor,
                    fontSize: 18,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.openInstructorDetail();
                    },
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.yellowColor,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    controller.getRating(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 32),
                  const Icon(
                    Icons.access_time_rounded,
                    size: 18,
                    color: AppColors.mentorAbout,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    controller.getDuration(),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 18,
                      color: AppColors.mentorAbout,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.only(
                    top: 2, bottom: 2, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.bookMarkTitleColor,
                ),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        AppUtils().formatAmount(controller.getPrice()),
                        style: TextStyles().textStyleRoboto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      if (controller.isDiscountAvailable()) ...[
                        const SizedBox(width: 4),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            AppUtils().formatAmount(
                                controller.getDiscountPrice().toString()),
                            style: TextStyles().textStyleRoboto(
                                fontSize: 12,
                                color: AppColors.darkGray,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Description',
            style: TextStyles().textStyleRoboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // HtmlWidget(
          //   controller.getDescription(),
          // ),
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    controller.getDescription(),
                    maxLines: controller.isExpanded.value ? null : 3,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 14,
                      color: AppColors.mentorAbout,
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.showReadMore(),
                  child: GestureDetector(
                    onTap: controller.toggleExpanded,
                    child: Text(
                      translate(
                          MyGlobals.navKey.currentContext,
                          controller.isExpanded.value
                              ? 'course.readLess'
                              : 'course.readMore'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.isCoursePurchased()) ...[
          _buildProgressCard(context),
          const SizedBox(height: 16),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate(
                    MyGlobals.navKey.currentContext, "course.lessons.lessons"),
                style: TextStyles().textStyleRoboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (controller.isCoursePurchased())
                Obx(
                  () => Text(
                    "${controller.getCompletedCount()}/${controller.getLessons().length} ${translate(MyGlobals.navKey.currentContext, 'course.completed')}",
                    style: TextStyles().textStyleRoboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildCheckLesson(),
      ],
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Obx(() {
      final double progress = controller.courseProgress.value;
      final int percent = (progress * 100).toInt();
      final bool isDone = progress >= 1.0;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDone ? const Color(0xFFFFFDF5) : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDone
                ? const Color(0xFFD4AF37).withValues(alpha: 0.6)
                : AppColors.platinumBorder,
            width: isDone ? 1.5 : 1.0,
          ),
          boxShadow: isDone
              ? [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isDone
                      ? Icons.workspace_premium_rounded
                      : Icons.trending_up_rounded,
                  size: 20,
                  color:
                      isDone ? const Color(0xFFB8860B) : AppColors.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  translate(
                      MyGlobals.navKey.currentContext, 'course.courseProgress'),
                  style: TextStyles().textStyleRoboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  "$percent%",
                  style: TextStyles().textStyleRoboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDone
                        ? const Color(0xFFB8860B)
                        : AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: AppColors.platinumBorder,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDone ? const Color(0xFFD4AF37) : AppColors.primaryColor,
                ),
              ),
            ),
            if (isDone) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.celebration_rounded,
                      size: 22,
                      color: Color(0xFFB8860B),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translate(MyGlobals.navKey.currentContext,
                                'course.courseCompleted'),
                            style: TextStyles().textStyleRoboto(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            translate(MyGlobals.navKey.currentContext,
                                'course.certificateReady'),
                            style: TextStyles().textStyleRoboto(
                              fontSize: 11,
                              color: AppColors.mentorAbout,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _showCertificateDialog(context),
                      icon: const Icon(Icons.workspace_premium_rounded,
                          size: 15, color: AppColors.white),
                      label: Text(
                        translate(MyGlobals.navKey.currentContext,
                            'course.viewCertificate'),
                        style: TextStyles().textStyleRoboto(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildCheckLesson() {
    if (controller.getLessons().isNotEmpty) {
      List<LessonsModel?> sortedLessons = List.from(controller.getLessons())
        ..sort((a, b) {
          DateTime dateA =
              DateTime.tryParse(a?.createdAt ?? '') ?? DateTime(1970);
          DateTime dateB =
              DateTime.tryParse(b?.createdAt ?? '') ?? DateTime(1970);
          return dateA.compareTo(dateB);
        });

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children:
              sortedLessons.map((lesson) => _buildLesson(lesson)).toList(),
        ),
      );
    }
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          VaNoDataWidget(),
        ],
      ),
    );
  }

  Widget _buildLesson(LessonsModel? item) {
    int lessonId = item?.id ?? 0;
    bool isPurchased = controller.isCoursePurchased();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.platinumBorder),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                controller.openVideoPlayer(item);
              },
              child: Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.openVideoPlayer(item);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.name ?? '',
                      style: TextStyles().textStyleRoboto(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "${item?.lessonsVideoCount ?? ""} ${translate(MyGlobals.navKey.currentContext, "course.lessons.video")}",
                      style: TextStyles().textStyleRoboto(
                        color: AppColors.mentorAbout,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isPurchased && lessonId > 0)
              Obx(() {
                bool isDone = controller.isLessonDone(lessonId);
                return IconButton(
                  tooltip: translate(MyGlobals.navKey.currentContext,
                      isDone ? 'course.completed' : 'course.markAsCompleted'),
                  icon: Icon(
                    isDone
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: isDone
                        ? AppColors.primaryColor
                        : AppColors.mentorAbout,
                    size: 22,
                  ),
                  onPressed: () {
                    controller.toggleLessonDone(lessonId);
                  },
                );
              }),
            GestureDetector(
              onTap: () {
                controller.openVideoPlayer(item);
              },
              child: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.mentorAbout,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCertificateDialog(BuildContext context) {
    final user = SharedPreferenceHelper.getUser();
    String studentName = "Alex Morgan";
    if (!controller.isDemoUser()) {
      String full = "${user?.firstName ?? ''} ${user?.lastName ?? ''}".trim();
      if (full.isNotEmpty) studentName = full;
    }
    final String courseName = controller.getName();
    final String instructorName = controller.getInstructorName();
    final String dateStr = DateTime.now().toLocal().toString().split(' ')[0];
    final String credentialId =
        "SKL-CERT-${controller.courseDetails?.value?.id ?? 1}-2026";

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD4AF37),
                  width: 2.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFD4AF37).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "SKILLORA VERIFIED",
                          style: TextStyles().textStyleRoboto(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFB8860B),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded,
                            size: 20, color: AppColors.mentorAbout),
                        onPressed: () => Navigator.pop(ctx),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Icon(
                    Icons.workspace_premium_rounded,
                    size: 52,
                    color: Color(0xFFD4AF37),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translate(MyGlobals.navKey.currentContext,
                        'course.certificateTitle'),
                    textAlign: TextAlign.center,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.black,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 60,
                    height: 2,
                    color: const Color(0xFFD4AF37),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    translate(MyGlobals.navKey.currentContext,
                        'course.certifyThat'),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: AppColors.mentorAbout,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    studentName,
                    textAlign: TextAlign.center,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    translate(MyGlobals.navKey.currentContext,
                        'course.completedCourseDesc'),
                    textAlign: TextAlign.center,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 12,
                      color: AppColors.labelColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    courseName,
                    textAlign: TextAlign.center,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.platinumBorder),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate(MyGlobals.navKey.currentContext,
                                  'course.issuedOn'),
                              style: TextStyles().textStyleRoboto(
                                fontSize: 10,
                                color: AppColors.mentorAbout,
                              ),
                            ),
                            Text(
                              dateStr,
                              style: TextStyles().textStyleRoboto(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              translate(MyGlobals.navKey.currentContext,
                                  'course.credentialId'),
                              style: TextStyles().textStyleRoboto(
                                fontSize: 10,
                                color: AppColors.mentorAbout,
                              ),
                            ),
                            Text(
                              credentialId,
                              style: TextStyles().textStyleRoboto(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              instructorName,
                              style: TextStyles().textStyleRoboto(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: AppColors.black,
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 1,
                              color: AppColors.darkGray,
                              margin: const EdgeInsets.symmetric(vertical: 3),
                            ),
                            Text(
                              translate(MyGlobals.navKey.currentContext,
                                  'course.instructorSignature'),
                              style: TextStyles().textStyleRoboto(
                                fontSize: 10,
                                color: AppColors.mentorAbout,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            try {
                              String shareMsg =
                                  "🎓 Proud to announce that I have successfully completed the course '$courseName' by $instructorName on Skillora! Credential ID: $credentialId";
                              await Share.share(shareMsg,
                                  subject: "My Course Completion Certificate");
                            } catch (e) {
                              debugPrint("Share certificate error: $e");
                            }
                          },
                          icon: const Icon(Icons.share_rounded,
                              size: 16, color: AppColors.primaryColor),
                          label: Text(
                            translate(MyGlobals.navKey.currentContext,
                                'course.shareCertificate'),
                            style: TextStyles().textStyleRoboto(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: AppColors.primaryColor, width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTabButton(
                title:
                    "${translate(MyGlobals.navKey.currentContext, 'course.lessons.lessons')} (${controller.getLessons().length})",
                index: 0,
              ),
              const SizedBox(width: 8),
              _buildTabButton(
                title:
                    "${translate(MyGlobals.navKey.currentContext, 'course.reviews')} (${controller.reviewsList.length})",
                index: 1,
              ),
              const SizedBox(width: 8),
              _buildTabButton(
                title:
                    "${translate(MyGlobals.navKey.currentContext, 'course.qa')} (${controller.questionsList.length})",
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton({required String title, required int index}) {
    bool isSelected = controller.tabController.selectedIndex.value == index;
    return GestureDetector(
      onTap: () {
        controller.tabController.selectedIndex.value = index;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.platinumBorder,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyles().textStyleRoboto(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingSummaryCard(),
          const SizedBox(height: 14),
          _buildWriteReviewAction(context),
          const SizedBox(height: 16),
          _buildReviewsList(),
        ],
      ),
    );
  }

  Widget _buildRatingSummaryCard() {
    return Obx(() {
      double avgRating = controller.getAverageRating();
      int totalReviews = controller.getTotalReviewsCount();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.platinumBorder),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    avgRating.toStringAsFixed(1),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < avgRating.round()
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: AppColors.yellowColor,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalReviews ${translate(MyGlobals.navKey.currentContext, 'course.reviews').toLowerCase()}',
                    style: TextStyles().textStyleRoboto(
                      fontSize: 12,
                      color: AppColors.mentorAbout,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 1,
              height: 75,
              color: AppColors.platinumBorder,
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 6,
              child: Column(
                children: [5, 4, 3, 2, 1].map((star) {
                  double pct = controller.getStarPercentage(star);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.5),
                    child: Row(
                      children: [
                        Text(
                          '$star',
                          style: TextStyles().textStyleRoboto(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mentorAbout,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(
                          Icons.star_rounded,
                          size: 12,
                          color: AppColors.yellowColor,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: pct,
                              minHeight: 6,
                              backgroundColor: AppColors.platinumBorder,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        SizedBox(
                          width: 26,
                          child: Text(
                            '${(pct * 100).toInt()}%',
                            textAlign: TextAlign.end,
                            style: TextStyles().textStyleRoboto(
                              fontSize: 10,
                              color: AppColors.mentorAbout,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWriteReviewAction(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showWriteReviewBottomSheet(context),
        icon: const Icon(Icons.rate_review_outlined,
            size: 18, color: AppColors.primaryColor),
        label: Text(
          translate(MyGlobals.navKey.currentContext, 'course.writeReview'),
          style: TextStyles().textStyleRoboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildReviewsList() {
    return Obx(() {
      if (controller.isReviewsLoading.value) {
        return const Center(child: VALoader());
      }
      if (controller.reviewsList.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                const Icon(Icons.reviews_outlined,
                    size: 40, color: AppColors.darkGray),
                const SizedBox(height: 8),
                Text(
                  translate(
                      MyGlobals.navKey.currentContext, 'course.noReviews'),
                  style: TextStyles().textStyleRoboto(
                    fontSize: 13,
                    color: AppColors.mentorAbout,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.reviewsList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final review = controller.reviewsList[index];
          return _buildReviewCard(review);
        },
      );
    });
  }

  Widget _buildReviewCard(ReviewModel review) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: VAImageAsset(
                    image: review.userImage ?? '',
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName ?? '',
                      style: TextStyles().textStyleRoboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      review.createdAt ?? '',
                      style: TextStyles().textStyleRoboto(
                        fontSize: 11,
                        color: AppColors.mentorAbout,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < (review.rating ?? 5.0).round()
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: AppColors.yellowColor,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.comment ?? '',
            style: TextStyles().textStyleRoboto(
              fontSize: 13,
              color: AppColors.black,
            ),
          ),
          if (review.instructorReply != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.bgColorWhite,
                borderRadius: BorderRadius.circular(8),
                border: const Border(
                  left: BorderSide(
                    color: AppColors.primaryColor,
                    width: 3.5,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: VAImageAsset(
                            image:
                                review.instructorReply?.instructorImage ?? '',
                            boxFit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        review.instructorReply?.instructorName ?? '',
                        style: TextStyles().textStyleRoboto(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          translate(MyGlobals.navKey.currentContext,
                              'course.instructorReply'),
                          style: TextStyles().textStyleRoboto(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        review.instructorReply?.createdAt ?? '',
                        style: TextStyles().textStyleRoboto(
                          fontSize: 10,
                          color: AppColors.mentorAbout,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    review.instructorReply?.replyText ?? '',
                    style: TextStyles().textStyleRoboto(
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showWriteReviewBottomSheet(BuildContext context) {
    final RxDouble selectedStars = 5.0.obs;
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.platinumBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  translate(
                      MyGlobals.navKey.currentContext, 'course.rateThisCourse'),
                  style: TextStyles().textStyleRoboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.getName(),
                  textAlign: TextAlign.center,
                  style: TextStyles().textStyleRoboto(
                    fontSize: 13,
                    color: AppColors.mentorAbout,
                  ),
                ),
                const SizedBox(height: 14),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      double starValue = index + 1.0;
                      return IconButton(
                        icon: Icon(
                          starValue <= selectedStars.value
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 34,
                          color: AppColors.yellowColor,
                        ),
                        onPressed: () {
                          selectedStars.value = starValue;
                        },
                      );
                    }),
                  ),
                ),
                Obx(
                  () => Text(
                    "${selectedStars.value.toInt()} / 5 Stars",
                    style: TextStyles().textStyleRoboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  style: TextStyles().textStyleRoboto(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: translate(
                        MyGlobals.navKey.currentContext, 'course.yourReview'),
                    hintStyle: TextStyles().textStyleRoboto(
                      fontSize: 13,
                      color: AppColors.mentorAbout,
                    ),
                    filled: true,
                    fillColor: AppColors.platinumBorder,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: VAButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () async {
                      if (commentController.text.trim().isEmpty) {
                        controller.showMessage(
                            "Please enter your feedback before submitting.");
                        return;
                      }
                      Navigator.pop(ctx);
                      await controller.submitReview(
                        rating: selectedStars.value,
                        comment: commentController.text.trim(),
                      );
                    },
                    text: translate(MyGlobals.navKey.currentContext,
                            'course.submitReview')
                        .toUpperCase(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      commentController.dispose();
    });
  }

  Widget _buildQAView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAskQuestionAction(context),
          const SizedBox(height: 16),
          _buildQuestionsList(context),
        ],
      ),
    );
  }

  Widget _buildAskQuestionAction(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showAskQuestionBottomSheet(context),
        icon: const Icon(Icons.help_outline_rounded,
            size: 18, color: AppColors.primaryColor),
        label: Text(
          translate(MyGlobals.navKey.currentContext, 'course.askQuestion'),
          style: TextStyles().textStyleRoboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildQuestionsList(BuildContext context) {
    return Obx(() {
      if (controller.isQuestionsLoading.value) {
        return const Center(child: VALoader());
      }
      if (controller.questionsList.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                const Icon(Icons.forum_outlined,
                    size: 40, color: AppColors.darkGray),
                const SizedBox(height: 8),
                Text(
                  translate(
                      MyGlobals.navKey.currentContext, 'course.noQuestions'),
                  style: TextStyles().textStyleRoboto(
                    fontSize: 13,
                    color: AppColors.mentorAbout,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.questionsList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (ctx, index) {
          final question = controller.questionsList[index];
          return _buildQuestionCard(context, question);
        },
      );
    });
  }

  Widget _buildQuestionCard(BuildContext context, QuestionModel question) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 34,
                  height: 34,
                  child: VAImageAsset(
                    image: question.userImage ?? '',
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.userName ?? '',
                      style: TextStyles().textStyleRoboto(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      question.createdAt ?? '',
                      style: TextStyles().textStyleRoboto(
                        fontSize: 11,
                        color: AppColors.mentorAbout,
                      ),
                    ),
                  ],
                ),
              ),
              if (question.lessonName != null &&
                  question.lessonName!.isNotEmpty)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.platinumBorder,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    question.lessonName!,
                    style: TextStyles().textStyleRoboto(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            question.title ?? '',
            style: TextStyles().textStyleRoboto(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            question.description ?? '',
            style: TextStyles().textStyleRoboto(
              fontSize: 13,
              color: AppColors.labelColor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.thumb_up_alt_outlined,
                  size: 14, color: AppColors.mentorAbout),
              const SizedBox(width: 4),
              Text(
                '${question.upvotes ?? 0}',
                style: TextStyles().textStyleRoboto(
                  fontSize: 12,
                  color: AppColors.mentorAbout,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.chat_bubble_outline_rounded,
                  size: 14, color: AppColors.mentorAbout),
              const SizedBox(width: 4),
              Text(
                '${question.answers?.length ?? 0} ${translate(MyGlobals.navKey.currentContext, 'course.answers').toLowerCase()}',
                style: TextStyles().textStyleRoboto(
                  fontSize: 12,
                  color: AppColors.mentorAbout,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _showReplyBottomSheet(context, question),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.reply_rounded,
                          size: 14, color: AppColors.primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        translate(
                            MyGlobals.navKey.currentContext, 'course.reply'),
                        style: TextStyles().textStyleRoboto(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (question.answers != null && question.answers!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.platinumBorder),
                ),
              ),
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: question.answers!.map((answer) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: answer.isInstructor
                            ? AppColors.bgColorWhite
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: answer.isInstructor
                              ? AppColors.primaryColor.withValues(alpha: 0.3)
                              : AppColors.platinumBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: VAImageAsset(
                                    image: answer.authorImage ?? '',
                                    boxFit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                answer.authorName ?? '',
                                style: TextStyles().textStyleRoboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              if (answer.isInstructor) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    translate(MyGlobals.navKey.currentContext,
                                        'course.instructorBadge'),
                                    style: TextStyles().textStyleRoboto(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                              const Spacer(),
                              Text(
                                answer.createdAt ?? '',
                                style: TextStyles().textStyleRoboto(
                                  fontSize: 10,
                                  color: AppColors.mentorAbout,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            answer.answerText ?? '',
                            style: TextStyles().textStyleRoboto(
                              fontSize: 12,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAskQuestionBottomSheet(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    final Rx<String?> selectedLesson = Rx<String?>(null);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.platinumBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  translate(
                      MyGlobals.navKey.currentContext, 'course.askQuestion'),
                  style: TextStyles().textStyleRoboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 14),
                if (controller.getLessons().isNotEmpty) ...[
                  Builder(builder: (_) {
                    final validLessons = <String>[];
                    for (var l in controller.getLessons()) {
                      final n = l.name?.trim();
                      if (n != null &&
                          n.isNotEmpty &&
                          !validLessons.contains(n)) {
                        validLessons.add(n);
                      }
                    }
                    if (validLessons.isEmpty) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: AppColors.platinumBorder,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String?>(
                                value:
                                    validLessons.contains(selectedLesson.value)
                                        ? selectedLesson.value
                                        : null,
                                isExpanded: true,
                                hint: Text(
                                  translate(MyGlobals.navKey.currentContext,
                                      'course.selectLesson'),
                                  style: TextStyles().textStyleRoboto(
                                    fontSize: 13,
                                    color: AppColors.mentorAbout,
                                  ),
                                ),
                                items: [
                                  DropdownMenuItem<String?>(
                                    value: null,
                                    child: Text(
                                      translate(MyGlobals.navKey.currentContext,
                                          'course.allLessons'),
                                      style: TextStyles()
                                          .textStyleRoboto(fontSize: 13),
                                    ),
                                  ),
                                  ...validLessons.map((name) {
                                    return DropdownMenuItem<String?>(
                                      value: name,
                                      child: Text(
                                        name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyles()
                                            .textStyleRoboto(fontSize: 13),
                                      ),
                                    );
                                  }),
                                ],
                                onChanged: (val) {
                                  selectedLesson.value = val;
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }),
                ],
                TextField(
                  controller: titleController,
                  style: TextStyles().textStyleRoboto(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: translate(MyGlobals.navKey.currentContext,
                        'course.questionTitleHint'),
                    hintStyle: TextStyles().textStyleRoboto(
                      fontSize: 13,
                      color: AppColors.mentorAbout,
                    ),
                    labelText: translate(MyGlobals.navKey.currentContext,
                        'course.questionTitle'),
                    labelStyle: TextStyles().textStyleRoboto(
                      fontSize: 14,
                      color: AppColors.labelColor,
                    ),
                    filled: true,
                    fillColor: AppColors.platinumBorder,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  maxLines: 4,
                  style: TextStyles().textStyleRoboto(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: translate(MyGlobals.navKey.currentContext,
                        'course.questionDesc'),
                    hintStyle: TextStyles().textStyleRoboto(
                      fontSize: 13,
                      color: AppColors.mentorAbout,
                    ),
                    filled: true,
                    fillColor: AppColors.platinumBorder,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: VAButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () async {
                      if (titleController.text.trim().isEmpty) {
                        controller.showMessage(
                            "Please enter a question title.");
                        return;
                      }
                      if (descController.text.trim().isEmpty) {
                        controller.showMessage(
                            "Please describe your question.");
                        return;
                      }
                      Navigator.pop(ctx);
                      await controller.submitQuestion(
                        title: titleController.text.trim(),
                        description: descController.text.trim(),
                        lessonName: selectedLesson.value,
                      );
                    },
                    text: translate(MyGlobals.navKey.currentContext,
                            'course.postQuestion')
                        .toUpperCase(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      titleController.dispose();
      descController.dispose();
    });
  }

  void _showReplyBottomSheet(BuildContext context, QuestionModel question) {
    final TextEditingController replyController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.platinumBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  translate(MyGlobals.navKey.currentContext, 'course.reply'),
                  style: TextStyles().textStyleRoboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  question.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles().textStyleRoboto(
                    fontSize: 13,
                    color: AppColors.mentorAbout,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: replyController,
                  maxLines: 3,
                  style: TextStyles().textStyleRoboto(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: translate(
                        MyGlobals.navKey.currentContext, 'course.writeReply'),
                    hintStyle: TextStyles().textStyleRoboto(
                      fontSize: 13,
                      color: AppColors.mentorAbout,
                    ),
                    filled: true,
                    fillColor: AppColors.platinumBorder,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: VAButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () async {
                      if (replyController.text.trim().isEmpty) {
                        controller
                            .showMessage("Please enter your reply text.");
                        return;
                      }
                      Navigator.pop(ctx);
                      await controller.submitAnswer(
                        questionId: question.id ?? 0,
                        answerText: replyController.text.trim(),
                      );
                    },
                    text: translate(MyGlobals.navKey.currentContext,
                            'course.sendReply')
                        .toUpperCase(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      replyController.dispose();
    });
  }

  Widget _buildButton(BuildContext context) {
    if (controller.isLoading.value ||
        (controller.courseDetails?.value?.purchase ?? false)) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Obx(
        () => VAButton(
          isLoading: controller.isPaymentLoading.value,
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            controller.consumePurchase(context);
          },
          text: translate(MyGlobals.navKey.currentContext, 'course.enrollNow'),
        ),
      ),
    );
  }
}
