import 'dart:async';
import 'package:instructor_app/mock/mock_instructor_data.dart';
import 'package:instructor_app/model/course_manage_model.dart';
import 'package:instructor_app/model/dashboard_stats_model.dart';
import 'package:instructor_app/model/notification_item_model.dart';
import 'package:instructor_app/model/payout_model.dart';
import 'package:instructor_app/model/question_answer_model.dart';
import 'package:instructor_app/model/review_item_model.dart';
import 'package:instructor_app/model/user_model.dart';

class ApiServices {
  final MockInstructorData _mock = MockInstructorData();
  final Duration _delay = const Duration(milliseconds: 250);

  // Auth Services
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(_delay);
    if (email.isNotEmpty) {
      _mock.currentInstructor.email = email;
    }
    return _mock.currentInstructor;
  }

  Future<UserModel?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String headline,
    required String bio,
    required String category,
    required String password,
  }) async {
    await Future.delayed(_delay);
    _mock.currentInstructor = UserModel(
      id: 1,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      headline: headline,
      bio: bio,
      category: category,
      avatar: "assets/images/mentor_one.png",
      token: "mock_instructor_token_${DateTime.now().millisecondsSinceEpoch}",
    );
    return _mock.currentInstructor;
  }

  Future<bool> forgotPassword(String email) async {
    await Future.delayed(_delay);
    return true;
  }

  Future<bool> verifyOtp(String otp) async {
    await Future.delayed(_delay);
    return true;
  }

  // Dashboard Stats
  Future<DashboardStatsModel> getDashboardStats() async {
    await Future.delayed(_delay);
    int totalStudents =
        _mock.courses.fold(0, (sum, c) => sum + c.studentCount);
    double totalRev = _mock.transactions.fold(0.0, (sum, t) => sum + t.amount);

    return DashboardStatsModel(
      totalStudents: totalStudents > 0 ? totalStudents : 920,
      totalFollowers: 890,
      totalCourses: _mock.courses.length,
      avgRating: 4.9,
      totalRevenue: totalRev + 8400.0,
      availableBalance: 3840.0,
      recentTransactions: _mock.transactions,
    );
  }

  // Courses
  Future<List<CourseManageModel>> getCourses() async {
    await Future.delayed(_delay);
    return List.from(_mock.courses);
  }

  Future<CourseManageModel?> getCourseById(int courseId) async {
    await Future.delayed(_delay);
    try {
      return _mock.courses.firstWhere((c) => c.id == courseId);
    } catch (_) {
      return null;
    }
  }

  Future<bool> saveCourse(CourseManageModel course) async {
    await Future.delayed(_delay);
    if (course.id != null && course.id! > 0) {
      int index = _mock.courses.indexWhere((c) => c.id == course.id);
      if (index >= 0) {
        _mock.courses[index] = course;
        return true;
      }
    }
    course.id = _mock.courses.length + 1;
    course.createdAt = DateTime.now().toString().split(' ')[0];
    _mock.courses.insert(0, course);
    return true;
  }

  Future<bool> deleteCourse(int courseId) async {
    await Future.delayed(_delay);
    _mock.courses.removeWhere((c) => c.id == courseId);
    return true;
  }

  // Q&A Hub
  Future<List<QuestionItemModel>> getQuestions() async {
    await Future.delayed(_delay);
    return List.from(_mock.questions);
  }

  Future<bool> replyQuestion(int questionId, String answerText) async {
    await Future.delayed(_delay);
    try {
      var q = _mock.questions.firstWhere((item) => item.id == questionId);
      q.isAnswered = true;
      q.answers.add(
        AnswerItemModel(
          id: DateTime.now().millisecondsSinceEpoch,
          userName: _mock.currentInstructor.fullName,
          isInstructor: true,
          answer: answerText,
          createdAt: DateTime.now().toString().substring(0, 16),
        ),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  // Reviews
  Future<List<ReviewItemModel>> getReviews() async {
    await Future.delayed(_delay);
    return List.from(_mock.reviews);
  }

  Future<bool> replyReview(int reviewId, String replyText) async {
    await Future.delayed(_delay);
    try {
      var r = _mock.reviews.firstWhere((item) => item.id == reviewId);
      r.instructorReply = replyText;
      r.replyCreatedAt = DateTime.now().toString().split(' ')[0];
      return true;
    } catch (_) {
      return false;
    }
  }

  // Payouts & Transactions
  Future<List<PayoutTransactionModel>> getTransactions() async {
    await Future.delayed(_delay);
    return List.from(_mock.transactions);
  }

  Future<bool> requestPayout(double amount, String method) async {
    await Future.delayed(_delay);
    return true;
  }

  // Notifications
  Future<List<NotificationItemModel>> getNotifications() async {
    await Future.delayed(_delay);
    return List.from(_mock.notifications);
  }

  Future<void> markNotificationAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _mock.notifications.indexWhere((n) => n.id == id);
    if (index >= 0) {
      _mock.notifications[index].isRead = true;
    }
  }

  Future<void> markAllNotificationsRead() async {
    await Future.delayed(const Duration(milliseconds: 100));
    for (var n in _mock.notifications) {
      n.isRead = true;
    }
  }

  Future<void> clearAllNotifications() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _mock.notifications.clear();
  }

  // Profile & Signature
  Future<UserModel> getProfile() async {
    await Future.delayed(_delay);
    return _mock.currentInstructor;
  }

  Future<bool> updateProfile(UserModel user) async {
    await Future.delayed(_delay);
    _mock.currentInstructor = user;
    return true;
  }

  Future<bool> saveDigitalSignature(String signature) async {
    await Future.delayed(_delay);
    _mock.currentInstructor.digitalSignature = signature;
    return true;
  }
}
