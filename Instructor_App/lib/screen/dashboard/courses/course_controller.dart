import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/course_manage_model.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/services/api_services.dart';

class CourseController extends BaseController {
  final RxList<CourseManageModel> courses = <CourseManageModel>[].obs;
  final RxString selectedFilter = 'all'.obs; // 'all', 'published', 'draft'

  // Form Controllers for Course Creation / Edit
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final discountPriceController = TextEditingController();
  final selectedCategory = 'Development'.obs;
  final selectedLevel = 'All Levels'.obs;
  final isFree = false.obs;
  final RxString selectedImage = 'assets/images/course_one.png'.obs;
  final List<String> availableThumbnails = ['assets/images/course_one.png', 'assets/images/course_two.png', 'assets/images/course_three.png'];
  final RxList<ModuleManageModel> modules = <ModuleManageModel>[].obs;
  CourseManageModel? editingCourse;

  final List<String> categories = [
    'Development',
    'Design',
    'Backend',
    'Mobile',
    'Business',
    'Marketing',
  ];

  final List<String> levels = [
    'All Levels',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  @override
  void onInitSetup() {
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      changeLoaderStatus(true);
      var fetched = await ApiServices().getCourses();
      courses.assignAll(fetched);
    } catch (e) {
      showError(e.toString());
    } finally {
      changeLoaderStatus(false);
    }
  }

  List<CourseManageModel> get filteredCourses {
    if (selectedFilter.value == 'published') {
      return courses.where((c) => c.status == 'published').toList();
    } else if (selectedFilter.value == 'draft') {
      return courses.where((c) => c.status == 'draft').toList();
    }
    return courses;
  }

  void initCreateForm([CourseManageModel? existing]) {
    editingCourse = existing;
    if (existing != null) {
      titleController.text = existing.title ?? '';
      descriptionController.text = existing.description ?? '';
      priceController.text = existing.price?.toString() ?? '0';
      discountPriceController.text = existing.discountPrice?.toString() ?? '0';
      selectedCategory.value = existing.category ?? 'Development';
      selectedLevel.value = existing.level ?? 'All Levels';
      isFree.value = existing.isFree;
      modules.assignAll(existing.modules);
      selectedImage.value = (existing.image != null && existing.image!.isNotEmpty) ? existing.image! : 'assets/images/course_one.png';
    } else {
      titleController.clear();
      descriptionController.clear();
      priceController.text = '49.99';
      discountPriceController.text = '29.99';
      selectedCategory.value = 'Development';
      selectedLevel.value = 'All Levels';
      isFree.value = false;
      selectedImage.value = 'assets/images/course_one.png';
      modules.clear();
      // Default initial module
      modules.add(
        ModuleManageModel(
          id: 1,
          title: "Module 1: Introduction",
          lessons: [
            LessonManageModel(
              id: 1,
              title: "Welcome & Setup",
              duration: "05:00",
              isPreview: true,
            ),
          ],
        ),
      );
    }
  }

  void addModule(String moduleTitle) {
    if (moduleTitle.trim().isEmpty) return;
    modules.add(
      ModuleManageModel(
        id: modules.length + 1,
        title: moduleTitle.trim(),
        lessons: [],
      ),
    );
  }

  void addLessonToModule(int moduleIndex, String lessonTitle, String duration,
      bool isPreview, String videoUrl) {
    if (moduleIndex < 0 || moduleIndex >= modules.length) return;
    if (lessonTitle.trim().isEmpty) return;
    modules[moduleIndex].lessons.add(
          LessonManageModel(
            id: DateTime.now().millisecondsSinceEpoch,
            title: lessonTitle.trim(),
            duration: duration.isNotEmpty ? duration : "10:00",
            isPreview: isPreview,
            videoUrl: videoUrl,
          ),
        );
    modules.refresh();
  }

  Future<bool> saveCourse({bool publish = true}) async {
    String title = titleController.text.trim();
    if (title.isEmpty) {
      showError("Please enter a course title");
      return false;
    }

    double price = isFree.value ? 0.0 : (double.tryParse(priceController.text.trim()) ?? 0.0);
    double discount = isFree.value ? 0.0 : (double.tryParse(discountPriceController.text.trim()) ?? 0.0);

    CourseManageModel courseToSave = CourseManageModel(
      id: editingCourse?.id,
      title: title,
      description: descriptionController.text.trim(),
      category: selectedCategory.value,
      price: price,
      discountPrice: discount,
      isFree: isFree.value,
      level: selectedLevel.value,
      image: selectedImage.value,
      status: publish ? "published" : "draft",
      studentCount: editingCourse?.studentCount ?? 0,
      rating: editingCourse?.rating ?? 5.0,
      reviewCount: editingCourse?.reviewCount ?? 0,
      modules: List.from(modules),
    );

    try {
      changeInnerLoaderStatus(true);
      bool success = await ApiServices().saveCourse(courseToSave);
      if (success) {
        showSuccess(publish
            ? "Course published successfully!"
            : "Course saved to drafts!");
        loadCourses();
        return true;
      }
      return false;
    } catch (e) {
      showError(e.toString());
      return false;
    } finally {
      changeInnerLoaderStatus(false);
    }
  }

  Future<void> deleteCourse(int courseId) async {
    try {
      changeInnerLoaderStatus(true);
      bool ok = await ApiServices().deleteCourse(courseId);
      if (ok) {
        courses.removeWhere((c) => c.id == courseId);
        showSuccess("Course deleted.");
      }
    } catch (e) {
      showError(e.toString());
    } finally {
      changeInnerLoaderStatus(false);
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    discountPriceController.dispose();
    super.onClose();
  }
}
