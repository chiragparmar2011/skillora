import 'dart:async';
import 'package:skillora/mock/mock_data.dart';
import 'package:skillora/model/user_model.dart';
import 'package:skillora/screen/drawer/course/lesson/model/lesson_model.dart';
import 'package:skillora/screen/drawer/course/lesson/model/video_model.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/course/model/question_model.dart';
import 'package:skillora/screen/drawer/course/model/review_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_detail_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/subcategory_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/model/home_model.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/screen/drawer/notification/model/notification_model.dart';
import 'package:skillora/screen/search/model/recent_search_model.dart';

class ApiServices {
  final MockData _mock = MockData();
  final Duration _delay = const Duration(milliseconds: 300);

  Future<UserModel?> register(Map<String, String> data) async {
    await Future.delayed(_delay);
    if (data.containsKey('first_name')) {
      _mock.currentUser.firstName = data['first_name'];
    }
    if (data.containsKey('last_name')) {
      _mock.currentUser.lastName = data['last_name'];
    }
    if (data.containsKey('email')) {
      _mock.currentUser.email = data['email'];
    }
    if (data.containsKey('phone')) {
      _mock.currentUser.phone = data['phone'];
    }
    return _mock.currentUser;
  }

  Future<UserModel?> login(Map<String, dynamic> data) async {
    await Future.delayed(_delay);
    if (data.containsKey('email') && data['email'] != null) {
      _mock.currentUser.email = data['email'];
    }
    return _mock.currentUser;
  }

  Future<String?> resetPassword(Map<String, String> data) async {
    await Future.delayed(_delay);
    return 'Password reset link sent to ${data['email'] ?? 'your email'}.';
  }

  Future<String?> otpVerify(Map<String, String> data) async {
    await Future.delayed(_delay);
    return 'verified_otp_token_mock';
  }

  Future<String?> updatePassword(Map<String, String> data) async {
    await Future.delayed(_delay);
    return 'Password updated successfully.';
  }

  Future<List<CategoryModel>?>? getAllCategories() async {
    await Future.delayed(_delay);
    return _mock.categories;
  }

  Future<List<VideoModel>?>? getLessonVideoList(String lessonId) async {
    await Future.delayed(_delay);
    int lId = int.tryParse(lessonId) ?? 1;
    return [
      VideoModel(
        id: 1,
        lessonId: lId,
        name: '01. Introduction & Overview',
        video:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        isPreview: 1,
      ),
      VideoModel(
        id: 2,
        lessonId: lId,
        name: '02. Hands-on Implementation',
        video:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        isPreview: 0,
      ),
    ];
  }

  Future<CategoryDetailModel?>? getCategory() async {
    await Future.delayed(_delay);
    return CategoryDetailModel(
      subcategory: _mock.subcategories,
      popularCourse: _mock.courses,
      popularInstructor: _mock.instructors,
    );
  }

  Future<List<SubCategoryModel>?>? getSubCategory() async {
    await Future.delayed(_delay);
    return _mock.subcategories;
  }

  Future<List<RecentSearchModel>> getRecentSearch() async {
    await Future.delayed(_delay);
    return _mock.recentSearches;
  }

  Future<HomeModel?>? getHomeData() async {
    await Future.delayed(_delay);
    return HomeModel(
      categoryList: _mock.categories,
      popularCourseList:
          _mock.courses.where((c) => c.isPopular == '1').toList(),
      trendingCourseList:
          _mock.courses.where((c) => c.isTrending == '1').toList(),
      instructorList: _mock.instructors,
    );
  }

  Future<UserModel?> getUserDetails() async {
    await Future.delayed(_delay);
    return _mock.currentUser;
  }

  Future<UserModel?> updateUser(Map<String, dynamic> data) async {
    await Future.delayed(_delay);
    if (data.containsKey('first_name')) {
      _mock.currentUser.firstName = data['first_name'];
    }
    if (data.containsKey('last_name')) {
      _mock.currentUser.lastName = data['last_name'];
    }
    if (data.containsKey('email')) {
      _mock.currentUser.email = data['email'];
    }
    if (data.containsKey('phone')) {
      _mock.currentUser.phone = data['phone'];
    }
    return _mock.currentUser;
  }

  Future<List<LessonsModel>?> getAllLessons() async {
    await Future.delayed(_delay);
    return _mock.courses.first.lessonList;
  }

  Future<String?> purchaseCourse(Map<String, dynamic> data) async {
    await Future.delayed(_delay);
    int courseId = 0;
    if (data.containsKey('course_id')) {
      courseId = int.tryParse(data['course_id'].toString()) ?? 0;
    }
    for (var course in _mock.courses) {
      if (course.id == courseId || courseId == 0) {
        course.purchaseSet = true;
      }
    }
    return 'Course purchased successfully!';
  }

  Future<List<InstructorModel>> getBestInstructor(
      {Map<String, dynamic>? data}) async {
    await Future.delayed(_delay);
    if (data != null && data.containsKey('search') && data['search'] != null) {
      String query = data['search'].toString().toLowerCase();
      if (query.isNotEmpty) {
        return _mock.instructors.where((inst) {
          String fullName =
              '${inst.firstName ?? ''} ${inst.lastName ?? ''}'.toLowerCase();
          String desig = (inst.designation ?? '').toLowerCase();
          return fullName.contains(query) || desig.contains(query);
        }).toList();
      }
    }
    return _mock.instructors;
  }

  Future<InstructorModel?> getSingleInstructor(int? instructorId) async {
    await Future.delayed(_delay);
    InstructorModel inst = _mock.instructors.firstWhere(
      (inst) => inst.id == instructorId,
      orElse: () => _mock.instructors.first,
    );
    List<CourseModel> instCourses = _mock.courses
        .where((c) => c.instructorId == inst.id || c.instructor?.id == inst.id)
        .toList();
    if (instCourses.isEmpty) {
      instCourses = List.from(_mock.courses);
    }
    inst.course = instCourses;
    inst.courseCount = instCourses.length;
    return inst;
  }

  Future<List<CourseModel>> getCourses(Map<String, dynamic> data) async {
    await Future.delayed(_delay);
    List<CourseModel> list = List.from(_mock.courses);

    if (data.containsKey('is_wishlist') &&
        (data['is_wishlist'] == 1 ||
            data['is_wishlist'] == '1' ||
            data['is_wishlist'] == true)) {
      list = list.where((c) => c.wishlist == true).toList();
    }

    if (data.containsKey('my_purchase') &&
        (data['my_purchase'] == 1 ||
            data['my_purchase'] == '1' ||
            data['my_purchase'] == true)) {
      list = list.where((c) => c.purchase == true).toList();
    }

    if (data.containsKey('category_id') &&
        data['category_id'] != null &&
        data['category_id'].toString().isNotEmpty) {
      String catId = data['category_id'].toString();
      list = list.where((c) => c.categoryId == catId).toList();
    }

    if (data.containsKey('subcategory_id') &&
        data['subcategory_id'] != null &&
        data['subcategory_id'].toString().isNotEmpty) {
      String subId = data['subcategory_id'].toString();
      list = list.where((c) => c.subcategoryId.toString() == subId).toList();
    }

    if (data.containsKey('search') && data['search'] != null) {
      String query = data['search'].toString().toLowerCase();
      if (query.isNotEmpty) {
        list = list
            .where((c) => (c.name ?? '').toLowerCase().contains(query))
            .toList();
      }
    }

    return list;
  }

  Future<List<CourseModel>> getBookMarkCourses(
      Map<String, dynamic> data) async {
    await Future.delayed(_delay);
    return _mock.courses.where((c) => c.wishlist == true).toList();
  }

  Future<CourseModel?> getCourseDetails(int courseId) async {
    await Future.delayed(_delay);
    return _mock.courses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => _mock.courses.first,
    );
  }

  Future<CategoryDetailModel?>? getCategoryDetail(int categoryId) async {
    await Future.delayed(_delay);
    List<SubCategoryModel> subCats =
        _mock.subcategories.where((s) => s.categoryId == categoryId).toList();
    List<CourseModel> catCourses = _mock.courses
        .where((c) => c.categoryId == categoryId.toString())
        .toList();
    if (catCourses.isEmpty) {
      catCourses = _mock.courses;
    }

    return CategoryDetailModel(
      subcategory: subCats,
      popularCourse: catCourses,
      popularInstructor: _mock.instructors,
    );
  }

  Future<Map<String, List<NotificationModel>>?> getNotification() async {
    await Future.delayed(_delay);
    return _mock.notifications;
  }

  Future<bool> bookmarkCourse(Map<String, dynamic> dataRequest) async {
    await Future.delayed(_delay);
    int courseId = 0;
    if (dataRequest.containsKey('course_id')) {
      courseId = int.tryParse(dataRequest['course_id'].toString()) ?? 0;
    }
    for (var c in _mock.courses) {
      if (c.id == courseId) {
        bool currentStatus = c.wishlist ?? false;
        c.wishlistSet = !currentStatus;
        return c.wishlist!;
      }
    }
    if (_mock.courses.isNotEmpty) {
      bool currentStatus = _mock.courses.first.wishlist ?? false;
      _mock.courses.first.wishlistSet = !currentStatus;
      return _mock.courses.first.wishlist!;
    }
    return true;
  }

  Future<Map<String, dynamic>> openPaymentIntent(
      Map<String, dynamic> body) async {
    await Future.delayed(_delay);
    return {
      'id': 'pi_mock_1234567890',
      'client_secret': 'pi_mock_1234567890_secret_mock999',
      'amount': body['amount'] ?? 9999,
      'currency': 'usd',
      'status': 'succeeded',
    };
  }

  Future<UserModel?> closeAccount() async {
    await Future.delayed(_delay);
    _mock.currentUser.firstName = 'Guest';
    _mock.currentUser.lastName = 'User';
    return _mock.currentUser;
  }

  Future<String?> changePushNotification(Map<String, dynamic> body) async {
    await Future.delayed(_delay);
    if (_mock.currentUser.settingModel != null) {
      String current = _mock.currentUser.settingModel!.notification ?? '1';
      _mock.currentUser.settingModel!.notification =
          (current == '1') ? '0' : '1';
    }
    return '1';
  }

  Future<String?> changeAutoPlay(Map<String, dynamic> data) async {
    await Future.delayed(_delay);
    if (_mock.currentUser.videoPreferenceModel != null) {
      String current =
          _mock.currentUser.videoPreferenceModel!.autoplayNextLecture ?? '1';
      _mock.currentUser.videoPreferenceModel!.autoplayNextLecture =
          (current == '1') ? '0' : '1';
    }
    return '1';
  }

  Future<String?> changePassword(Map<String, String> requestData) async {
    await Future.delayed(_delay);
    return 'Password changed successfully.';
  }

  Future<UserModel?> updateProfile(String path) async {
    await Future.delayed(_delay);
    _mock.currentUser.image = path;
    return _mock.currentUser;
  }

  Future<List<ReviewModel>> getCourseReviews(int? courseId) async {
    await Future.delayed(_delay);
    if (courseId == null) return [];
    return _mock.getReviewsForCourse(courseId);
  }

  Future<bool> addCourseReview({
    required int courseId,
    required double rating,
    required String comment,
  }) async {
    await Future.delayed(_delay);
    final user = _mock.currentUser;
    final newReview = ReviewModel(
      id: DateTime.now().millisecondsSinceEpoch,
      courseId: courseId,
      userName: '${user.firstName ?? 'Student'} ${user.lastName ?? ''}'.trim(),
      userImage: user.image ??
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&q=80',
      rating: rating,
      comment: comment,
      createdAt: 'Just now',
    );
    _mock.addReview(newReview);
    return true;
  }

  Future<List<QuestionModel>> getCourseQuestions(int? courseId) async {
    await Future.delayed(_delay);
    if (courseId == null) return [];
    return _mock.getQuestionsForCourse(courseId);
  }

  Future<bool> addCourseQuestion({
    required int courseId,
    required String title,
    required String description,
    int? lessonId,
    String? lessonName,
  }) async {
    await Future.delayed(_delay);
    final user = _mock.currentUser;
    final newQuestion = QuestionModel(
      id: DateTime.now().millisecondsSinceEpoch,
      courseId: courseId,
      lessonId: lessonId,
      lessonName: lessonName,
      userName: '${user.firstName ?? 'Student'} ${user.lastName ?? ''}'.trim(),
      userImage: user.image ??
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&q=80',
      title: title,
      description: description,
      createdAt: 'Just now',
      upvotes: 0,
      isResolved: false,
      answers: [],
    );
    _mock.addQuestion(newQuestion);
    return true;
  }

  Future<bool> addQuestionAnswer({
    required int questionId,
    required String answerText,
    bool isInstructor = false,
  }) async {
    await Future.delayed(_delay);
    final user = _mock.currentUser;
    final newAnswer = AnswerModel(
      id: DateTime.now().millisecondsSinceEpoch,
      authorName:
          '${user.firstName ?? 'Student'} ${user.lastName ?? ''}'.trim(),
      authorImage: user.image ??
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&q=80',
      isInstructor: isInstructor,
      answerText: answerText,
      createdAt: 'Just now',
    );
    _mock.addAnswer(questionId, newAnswer);
    return true;
  }

  Future<bool> followInstructor(int instructorId, bool follow) async {
    await Future.delayed(_delay);
    final instIndex = _mock.instructors.indexWhere((i) => i.id == instructorId);
    if (instIndex != -1) {
      if (follow) {
        _mock.instructors[instIndex].student =
            (_mock.instructors[instIndex].student ?? 0) + 1;
      } else {
        if ((_mock.instructors[instIndex].student ?? 0) > 0) {
          _mock.instructors[instIndex].student =
              (_mock.instructors[instIndex].student ?? 0) - 1;
        }
      }
    }
    return true;
  }
}
