import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/course/widget/course_widget.dart';
import 'package:skillora/screen/drawer/mentor/controller/instructor_detail_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/utilities/app_utils.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_image_asset.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_data_widget.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class InstructorDetailView extends StatelessWidget {
  InstructorDetailView({super.key});

  final InstructorDetailController controller =
      Get.put(InstructorDetailController());

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
                      appBarTitle: translate(MyGlobals.navKey.currentContext,
                          'instructor.instructor'),
                    ),
                    Expanded(
                      child: _buildBody(),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: VALoader(),
        );
      }
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMentorView(),
            const SizedBox(height: 16),
            _buildCourseView(),
          ],
        ),
      );
    });
  }

  Widget _buildMentorView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        elevation: 0,
        shadowColor: AppColors.secondaryColor,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(54),
                        child: VAImageAsset(
                          image: controller.getImage(),
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.getFirstName(),
                          style: TextStyles().textStyleRoboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          controller.getDesignation(),
                          style: TextStyles().textStyleRoboto(
                            fontSize: 16,
                            color: AppColors.dropShadow,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate(MyGlobals.navKey.currentContext,
                            'instructor.totalStudents'),
                        style: TextStyles().textStyleRoboto(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => Text(
                          '${controller.studentCount.value}',
                          style: TextStyles().textStyleRoboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate(MyGlobals.navKey.currentContext,
                            'instructor.review'),
                        style: TextStyles().textStyleRoboto(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${controller.getReview()}',
                        style: TextStyles().textStyleRoboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  _buildFollowButton(),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      AppUtils().launchWebSite(controller.getWebLink());
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.language_rounded,
                        color: AppColors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      AppUtils().launchWebSite(controller.getFacebookLink());
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.facebook_rounded,
                        color: AppColors.black,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () async {
                      await AppUtils()
                          .launchWebSite(controller.getInstagramLink());
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate(
                        MyGlobals.navKey.currentContext, 'instructor.aboutMe'),
                    style: TextStyles().textStyleRoboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ReadMoreText(
                    controller.getAbout(),
                    numLines: 4,
                    readMoreText: 'show more',
                    readLessText: 'show less',
                    style: TextStyles().textStyleRoboto(
                      fontSize: 14,
                      color: AppColors.mentorAbout,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseView() {
    List<CourseModel> courseList =
        controller.instructorModel.value?.course ?? <CourseModel>[];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '${translate(MyGlobals.navKey.currentContext, 'course.myCourses')}(${courseList.length})',
              style: TextStyles().textStyleRoboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          courseList.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      VaNoDataWidget(),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    CourseModel? courseModel = courseList[index];
                    return Card(
                      child: CourseWidget(
                        onTapDetail: () {
                          controller.openCourseDetail(courseModel);
                        },
                        courseModel: courseModel,
                        onTapBookmark: () {
                          controller.onTapBookMark(index);
                        },
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildFollowButton() {
    return Obx(() {
      final isFollowed = controller.isFollowed.value;
      final isLoading = controller.isFollowLoading.value;

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : () => controller.toggleFollow(),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isFollowed
                  ? AppColors.primaryColor.withValues(alpha: 0.12)
                  : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                ] else ...[
                  Icon(
                    isFollowed ? Icons.check_rounded : Icons.add_rounded,
                    size: 16,
                    color: isFollowed
                        ? AppColors.primaryColor
                        : AppColors.white,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  isFollowed
                      ? translate(MyGlobals.navKey.currentContext,
                          'instructor.following')
                      : translate(MyGlobals.navKey.currentContext,
                          'instructor.follow'),
                  maxLines: 1,
                  style: TextStyles().textStyleRoboto(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isFollowed
                        ? AppColors.primaryColor
                        : AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
