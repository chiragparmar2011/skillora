import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/screen/dashboard/courses/course_controller.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_styles.dart';
import 'package:instructor_app/widgets/va_appbar.dart';
import 'package:instructor_app/widgets/va_button.dart';
import 'package:instructor_app/widgets/va_image_asset.dart';
import 'package:instructor_app/widgets/va_text_form_field.dart';

class CourseCreateView extends StatelessWidget {
  CourseCreateView({super.key});

  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    bool isEditing = controller.editingCourse != null;

    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: VAAppBar(
        title: isEditing
            ? translate(context, 'course.editCourse')
            : translate(context, 'course.createNew'),
        actions: [
          TextButton(
            onPressed: () async {
              bool ok = await controller.saveCourse(publish: false);
              if (ok) Get.back();
            },
            child: Text(
              translate(context, 'course.saveDraft'),
              style: TextStyles().textStyleRoboto(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGray,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, "1. Course Basic Information"),
              const SizedBox(height: 12),

              // Course Thumbnail Selector & Preview
              Text(
                "Course Thumbnail Banner",
                style: TextStyles().textStyleRoboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: double.infinity,
                        height: 140,
                        child: VAImageAsset(
                          image: controller.selectedImage.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        for (int i = 0; i < controller.availableThumbnails.length; i++) ...[
                          GestureDetector(
                            onTap: () {
                              controller.selectedImage.value =
                                  controller.availableThumbnails[i];
                            },
                            child: Container(
                              width: 56,
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: controller.selectedImage.value ==
                                          controller.availableThumbnails[i]
                                      ? AppColors.primaryColor
                                      : AppColors.platinumBorder,
                                  width: controller.selectedImage.value ==
                                          controller.availableThumbnails[i]
                                      ? 2.5
                                      : 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: VAImageAsset(
                                  image: controller.availableThumbnails[i],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        const Spacer(),
                        Text(
                          "Tap to select banner",
                          style: TextStyles().textStyleRoboto(
                            fontSize: 11,
                            color: AppColors.mentorAbout,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              const SizedBox(height: 16),

              VATextFormField(
                controller: controller.titleController,
                labelText: translate(context, 'course.title'),
                hintText: "e.g., Complete Flutter 3 & Clean Architecture",
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate(context, 'course.category'),
                          style: TextStyles().textStyleRoboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: AppColors.platinumBorder),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: controller.selectedCategory.value,
                                items: controller.categories
                                    .map(
                                      (c) => DropdownMenuItem(
                                        value: c,
                                        child: Text(
                                          c,
                                          style: TextStyles().textStyleRoboto(
                                            fontSize: 13,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) {
                                    controller.selectedCategory.value = v;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate(context, 'course.level'),
                          style: TextStyles().textStyleRoboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: AppColors.platinumBorder),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: controller.selectedLevel.value,
                                items: controller.levels
                                    .map(
                                      (l) => DropdownMenuItem(
                                        value: l,
                                        child: Text(
                                          l,
                                          style: TextStyles().textStyleRoboto(
                                            fontSize: 13,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) {
                                    controller.selectedLevel.value = v;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              VATextFormField(
                controller: controller.descriptionController,
                labelText: translate(context, 'course.description'),
                hintText:
                    "Provide a thorough overview of the learning objectives, architecture patterns, and prerequisites.",
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(context, "2. Pricing & Enrollment"),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.platinumBorder),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate(context, 'course.freeCourse'),
                              style: TextStyles().textStyleRoboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              "Enable free open access for students",
                              style: TextStyles().textStyleRoboto(
                                fontSize: 11,
                                color: AppColors.mentorAbout,
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => Switch(
                            value: controller.isFree.value,
                            activeTrackColor: AppColors.primaryColor,
                            onChanged: (val) => controller.isFree.value = val,
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      if (controller.isFree.value) return const SizedBox();
                      return Column(
                        children: [
                          const Divider(
                              height: 16, color: AppColors.platinumBorder),
                          Row(
                            children: [
                              Expanded(
                                child: VATextFormField(
                                  controller: controller.priceController,
                                  labelText: translate(context, 'course.price'),
                                  hintText: "89.99",
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: VATextFormField(
                                  controller:
                                      controller.discountPriceController,
                                  labelText: translate(
                                      context, 'course.discountPrice'),
                                  hintText: "49.99",
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle(context, "3. Curriculum Builder"),
                  ElevatedButton.icon(
                    onPressed: () => _showAddModuleDialog(context),
                    icon: const Icon(Icons.add, size: 16, color: AppColors.white),
                    label: Text(
                      translate(context, 'course.addModule'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildCurriculumList(context),
              const SizedBox(height: 32),
              Obx(
                () => VAButton(
                  text: translate(context, 'course.publishNow'),
                  isLoading: controller.isInnerLoading.value,
                  onPressed: () async {
                    bool ok = await controller.saveCourse(publish: true);
                    if (ok) Get.back();
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyles().textStyleRoboto(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    );
  }

  // Curriculum Builder with aligned (+) and (-) buttons
  Widget _buildCurriculumList(BuildContext context) {
    return Obx(() {
      final list = controller.modules;
      if (list.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.platinumBorder),
          ),
          child: const Center(
            child: Text(
              "No modules added yet. Tap 'Add Module' to begin structuring your course curriculum.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.darkGray, fontSize: 13),
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, moduleIdx) {
          final mod = list[moduleIdx];
          return Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.platinumBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Module Header: horizontal padding 14
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withValues(alpha: 0.3),
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      // (+) Add Lesson Icon: identical right alignment
                      GestureDetector(
                        onTap: () => _showAddLessonDialog(context, moduleIdx),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.add_circle_outline,
                            size: 22,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (mod.lessons.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "No lessons in this module. Tap '+' to add video lessons.",
                      style: TextStyle(fontSize: 12, color: AppColors.darkGray),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mod.lessons.length,
                    separatorBuilder: (_, __) => const Divider(
                        height: 1, color: AppColors.platinumBorder),
                    itemBuilder: (context, lessonIdx) {
                      final les = mod.lessons[lessonIdx];
                      // Lesson Row: horizontal padding 14 matching header exactly
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.play_circle_outline_rounded,
                              color: AppColors.primaryColor,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    les.title,
                                    style: TextStyles().textStyleRoboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${les.duration}${les.isPreview ? ' â€¢ Free Preview' : ''}",
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
                            const SizedBox(width: 8),
                            // (-) Delete Lesson Icon: exactly aligned with (+) icon above
                            GestureDetector(
                              onTap: () {
                                if (lessonIdx >= 0 && lessonIdx < mod.lessons.length) { mod.lessons.removeAt(lessonIdx); }
                                controller.modules.refresh();
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 22,
                                  color: AppColors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      );
    });
  }

  // Proper compact modal UI-UX for Add Module dialog
  void _showAddModuleDialog(BuildContext context) {
    final textCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppColors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        actionsPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        title: Text(
          translate(context, 'course.addModule'),
          style: TextStyles().textStyleRoboto(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Module Title",
                style: TextStyles().textStyleRoboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: textCtrl,
                autofocus: true,
                style: TextStyles().textStyleRoboto(
                  fontSize: 14,
                  color: AppColors.black,
                ),
                decoration: InputDecoration(
                  hintText: "e.g., Module 2: State Management",
                  hintStyle: TextStyles().textStyleRoboto(
                    fontSize: 14,
                    color: AppColors.darkGray,
                  ),
                  filled: true,
                  fillColor: AppColors.secondaryColor.withValues(alpha: 0.1),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: AppColors.platinumBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: AppColors.platinumBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              translate(context, 'common.cancel'),
              style: TextStyles().textStyleRoboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGray,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (textCtrl.text.trim().isNotEmpty) {
                controller.addModule(textCtrl.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: Text(
              translate(context, 'common.save'),
              style: TextStyles().textStyleRoboto(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Proper compact modal UI-UX for Add Lesson dialog
  void _showAddLessonDialog(BuildContext context, int moduleIndex) {
    final titleCtrl = TextEditingController();
    final durCtrl = TextEditingController(text: "12:00");
    final urlCtrl = TextEditingController();
    final RxBool isPreview = false.obs;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppColors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        actionsPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        title: Text(
          translate(context, 'course.addLesson'),
          style: TextStyles().textStyleRoboto(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VATextFormField(
                  controller: titleCtrl,
                  labelText: translate(context, 'course.lessonName'),
                  hintText: "e.g., Reactive Variables & Obx",
                ),
                const SizedBox(height: 10),
                VATextFormField(
                  controller: durCtrl,
                  labelText: translate(context, 'course.duration'),
                  hintText: "12:00",
                ),
                const SizedBox(height: 10),
                VATextFormField(
                  controller: urlCtrl,
                  labelText: translate(context, 'course.videoUrl'),
                  hintText: "https://example.com/video.mp4",
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      translate(context, 'course.freePreview'),
                      style: TextStyles().textStyleRoboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    value: isPreview.value,
                    activeColor: AppColors.primaryColor,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (v) => isPreview.value = v ?? false,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              translate(context, 'common.cancel'),
              style: TextStyles().textStyleRoboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGray,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              controller.addLessonToModule(
                moduleIndex,
                titleCtrl.text,
                durCtrl.text,
                isPreview.value,
                urlCtrl.text,
              );
              Navigator.pop(ctx);
            },
            child: Text(
              translate(context, 'common.save'),
              style: TextStyles().textStyleRoboto(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}