import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/course_manage_model.dart';
import 'package:instructor_app/screen/dashboard/courses/course_controller.dart';
import 'package:instructor_app/screen/dashboard/courses/course_create_view.dart';
import 'package:instructor_app/screen/dashboard/courses/course_detail_manage_view.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/utilities/app_utils.dart';
import 'package:instructor_app/widgets/va_image_asset.dart';
import 'package:instructor_app/widgets/va_no_data_widget.dart';

class CourseListView extends StatelessWidget {
  CourseListView({super.key});

  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          translate(context, 'course.myCourses'),
          style: TextStyles().textStyleRoboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              controller.initCreateForm();
              Get.to(() => CourseCreateView());
            },
            icon: const Icon(Icons.add, size: 18, color: AppColors.primaryColor),
            label: Text(
              translate(context, 'dashboard.createNewCourse'),
              style: TextStyles().textStyleRoboto(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildFilterTabs(context),
          const Divider(height: 1, color: AppColors.platinumBorder),
          Expanded(
            child: Obx(() {
              final list = controller.filteredCourses;
              if (list.isEmpty) {
                return VANoDataWidget(
                  title: translate(context, 'course.noCoursesFound'),
                  subtitle: translate(context, 'course.createFirstCourse'),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.loadCourses(),
                color: AppColors.primaryColor,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return _buildCourseCard(context, list[index]);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    return Obx(() {
      return Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            _buildTabChip(
              label: "All (${controller.courses.length})",
              isSelected: controller.selectedFilter.value == 'all',
              onTap: () => controller.selectedFilter.value = 'all',
            ),
            const SizedBox(width: 8),
            _buildTabChip(
              label: translate(context, 'course.published'),
              isSelected: controller.selectedFilter.value == 'published',
              onTap: () => controller.selectedFilter.value = 'published',
            ),
            const SizedBox(width: 8),
            _buildTabChip(
              label: translate(context, 'course.draft'),
              isSelected: controller.selectedFilter.value == 'draft',
              onTap: () => controller.selectedFilter.value = 'draft',
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTabChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.secondaryColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyles().textStyleRoboto(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, CourseManageModel course) {
    bool isDraft = course.status == 'draft';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinumBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Get.to(() => CourseDetailManageView(course: course));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 82,
                    height: 82,
                    child: VAImageAsset(
                      image: (course.image != null && course.image!.isNotEmpty)
                          ? course.image!
                          : 'assets/images/course_one.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDraft
                                  ? AppColors.yellowColor.withValues(alpha: 0.15)
                                  : AppColors.green.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isDraft ? "DRAFT" : "PUBLISHED",
                              style: TextStyles().textStyleRoboto(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: isDraft
                                    ? AppColors.yellowColor
                                    : AppColors.green,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              course.category ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles().textStyleRoboto(
                                fontSize: 11,
                                color: AppColors.mentorAbout,
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              controller.initCreateForm(course);
                              Get.to(() => CourseCreateView());
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(Icons.edit_outlined,
                                  size: 17, color: AppColors.black),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () =>
                                _confirmDelete(context, course.id ?? 0),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(Icons.delete_outline_rounded,
                                  size: 17, color: AppColors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        course.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles().textStyleRoboto(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.people_outline_rounded,
                                  size: 13, color: AppColors.mentorAbout),
                              const SizedBox(width: 3),
                              Text(
                                "${course.studentCount} students",
                                style: TextStyles().textStyleRoboto(
                                  fontSize: 11,
                                  color: AppColors.mentorAbout,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.video_library_outlined,
                                  size: 13, color: AppColors.mentorAbout),
                              const SizedBox(width: 3),
                              Text(
                                "${course.totalLessons} lessons",
                                style: TextStyles().textStyleRoboto(
                                  fontSize: 11,
                                  color: AppColors.mentorAbout,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            course.isFree
                                ? "Free"
                                : AppUtils().formatAmount(
                                    course.discountPrice ?? course.price),
                            style: TextStyles().textStyleRoboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, int courseId) {
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