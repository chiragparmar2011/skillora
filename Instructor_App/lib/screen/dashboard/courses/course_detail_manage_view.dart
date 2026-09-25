import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/course_manage_model.dart';
import 'package:instructor_app/screen/dashboard/courses/course_controller.dart';
import 'package:instructor_app/screen/dashboard/courses/course_create_view.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/utilities/app_utils.dart';
import 'package:instructor_app/widgets/va_image_asset.dart';

class CourseDetailManageView extends StatelessWidget {
  final CourseManageModel course;

  const CourseDetailManageView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    bool isDraft = course.status == 'draft';
    final CourseController controller = Get.isRegistered<CourseController>()
        ? Get.find<CourseController>()
        : Get.put(CourseController());

    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          translate(context, 'course.detailsTitle'),
          style: TextStyles().textStyleRoboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.black, size: 20),
            tooltip: "Edit Course",
            onPressed: () {
              controller.initCreateForm(course);
              Get.to(() => CourseCreateView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Banner / Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: double.infinity,
                height: 180,
                child: VAImageAsset(
                  image: (course.image != null && course.image!.isNotEmpty)
                      ? course.image!
                      : 'assets/images/course_one.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Status, Category, Level row
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isDraft
                        ? AppColors.yellowColor.withValues(alpha: 0.15)
                        : AppColors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isDraft ? "DRAFT" : "PUBLISHED",
                    style: TextStyles().textStyleRoboto(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color:
                          isDraft ? AppColors.yellowColor : AppColors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    course.category ?? 'Development',
                    style: TextStyles().textStyleRoboto(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.platinumBorder.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    course.level ?? 'All Levels',
                    style: TextStyles().textStyleRoboto(
                      fontSize: 11,
                      color: AppColors.darkGray,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  course.isFree
                      ? "Free"
                      : AppUtils().formatAmount(
                          course.discountPrice ?? course.price),
                  style: TextStyles().textStyleRoboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Course Title
            Text(
              course.title ?? '',
              style: TextStyles().textStyleRoboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 14),

            // Stat Cards (3 compact metrics)
            Row(
              children: [
                Expanded(
                  child: _buildMetricBox(
                    icon: Icons.people_outline_rounded,
                    value: "${course.studentCount}",
                    label: "Students",
                    color: AppColors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricBox(
                    icon: Icons.video_library_outlined,
                    value: "${course.totalLessons}",
                    label: "Lessons",
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricBox(
                    icon: Icons.star_rounded,
                    value: "${course.rating}",
                    label: "${course.reviewCount} Reviews",
                    color: AppColors.yellowColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Description
            Text(
              "About Course",
              style: TextStyles().textStyleRoboto(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              course.description ?? 'No description provided.',
              style: TextStyles().textStyleRoboto(
                fontSize: 13,
                color: AppColors.darkGray,
              ),
            ),
            const SizedBox(height: 20),

            // Curriculum Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Curriculum (${course.modules.length} Modules)",
                  style: TextStyles().textStyleRoboto(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  "${course.totalLessons} Lessons",
                  style: TextStyles().textStyleRoboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mentorAbout,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            if (course.modules.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.platinumBorder),
                ),
                child: Center(
                  child: Text(
                    "No curriculum modules yet.",
                    style: TextStyles().textStyleRoboto(
                      fontSize: 13,
                      color: AppColors.mentorAbout,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: course.modules.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, moduleIdx) {
                  final mod = course.modules[moduleIdx];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.platinumBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                AppColors.secondaryColor.withValues(alpha: 0.3),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  mod.title,
                                  style: TextStyles().textStyleRoboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              Text(
                                "${mod.lessons.length} lessons",
                                style: TextStyles().textStyleRoboto(
                                  fontSize: 11,
                                  color: AppColors.mentorAbout,
                                ),
                              ),
                            ],
                          ),
                        ),
                        for (var les in mod.lessons)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 9),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.play_circle_outline_rounded,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        les.title,
                                        style: TextStyles().textStyleRoboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Text(
                                        "${les.duration}${les.isPreview ? ' • Free Preview' : ''}",
                                        style: TextStyles().textStyleRoboto(
                                          fontSize: 11,
                                          color: les.isPreview
                                              ? AppColors.green
                                              : AppColors.mentorAbout,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete_outline_rounded,
                        color: AppColors.red, size: 18),
                    label: Text(
                      translate(context, 'common.delete'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.red),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _confirmDelete(context, controller, course.id ?? 0);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit_rounded,
                        color: AppColors.white, size: 18),
                    label: Text(
                      translate(context, 'course.editCourse'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      controller.initCreateForm(course);
                      Get.to(() => CourseCreateView());
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricBox({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyles().textStyleRoboto(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          Text(
            label,
            style: TextStyles().textStyleRoboto(
              fontSize: 10,
              color: AppColors.mentorAbout,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
      BuildContext context, CourseController controller, int courseId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          translate(context, 'common.delete'),
          style: TextStyles().textStyleRoboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          translate(context, 'course.confirmDelete'),
          style: TextStyles().textStyleRoboto(
            fontSize: 13,
            color: AppColors.mentorAbout,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(translate(context, 'common.cancel')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              controller.deleteCourse(courseId);
              Get.back(); // Return from details to course list
            },
            child: Text(
              translate(context, 'common.delete'),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}