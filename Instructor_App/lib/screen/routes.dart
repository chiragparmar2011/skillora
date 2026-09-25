import 'package:get/get.dart';
import 'package:instructor_app/screen/auth/forgot_password/forgot_password_view.dart';
import 'package:instructor_app/screen/auth/otp/otp_view.dart';
import 'package:instructor_app/screen/auth/sign_in/sign_in_view.dart';
import 'package:instructor_app/screen/auth/sign_up/sign_up_view.dart';
import 'package:instructor_app/screen/dashboard/courses/course_create_view.dart';
import 'package:instructor_app/screen/dashboard/courses/course_list_view.dart';
import 'package:instructor_app/screen/dashboard/dashboard_view.dart';
import 'package:instructor_app/screen/dashboard/earnings/earnings_view.dart';
import 'package:instructor_app/screen/dashboard/home/notification_view.dart';
import 'package:instructor_app/screen/dashboard/home/recent_activity_view.dart';
import 'package:instructor_app/screen/dashboard/profile/digital_signature_view.dart';
import 'package:instructor_app/screen/dashboard/profile/edit_profile_view.dart';
import 'package:instructor_app/screen/dashboard/profile/profile_view.dart';
import 'package:instructor_app/screen/dashboard/qa/qa_view.dart';
import 'package:instructor_app/screen/dashboard/reviews/reviews_view.dart';
import 'package:instructor_app/screen/splash/splash_view.dart';

class RoutePath {
  static const String splash = '/';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String otpVerify = '/otpVerify';
  static const String dashboard = '/dashboard';
  static const String courseList = '/courseList';
  static const String createCourse = '/createCourse';
  static const String qa = '/qa';
  static const String reviews = '/reviews';
  static const String earnings = '/earnings';
  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String digitalSignature = '/digitalSignature';
  static const String recentActivity = '/recentActivity';
  static const String notifications = '/notifications';
}

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: RoutePath.splash,
      page: () => SplashView(),
    ),
    GetPage(
      name: RoutePath.signIn,
      page: () => SignInView(),
    ),
    GetPage(
      name: RoutePath.signUp,
      page: () => SignUpView(),
    ),
    GetPage(
      name: RoutePath.forgotPassword,
      page: () => ForgotPasswordView(),
    ),
    GetPage(
      name: RoutePath.otpVerify,
      page: () => OtpView(),
    ),
    GetPage(
      name: RoutePath.dashboard,
      page: () => DashboardView(),
    ),
    GetPage(
      name: RoutePath.courseList,
      page: () => CourseListView(),
    ),
    GetPage(
      name: RoutePath.createCourse,
      page: () => CourseCreateView(),
    ),
    GetPage(
      name: RoutePath.qa,
      page: () => QAView(),
    ),
    GetPage(
      name: RoutePath.reviews,
      page: () => ReviewsView(),
    ),
    GetPage(
      name: RoutePath.earnings,
      page: () => EarningsView(),
    ),
    GetPage(
      name: RoutePath.profile,
      page: () => ProfileView(),
    ),
    GetPage(
      name: RoutePath.editProfile,
      page: () => EditProfileView(),
    ),
    GetPage(
      name: RoutePath.digitalSignature,
      page: () => DigitalSignatureView(),
    ),
    GetPage(
      name: RoutePath.recentActivity,
      page: () => RecentActivityView(),
    ),
    GetPage(
      name: RoutePath.notifications,
      page: () => NotificationView(),
    ),
  ];
}
