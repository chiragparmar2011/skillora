import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/screen/drawer/bookmark/bookmark_view.dart';
import 'package:skillora/screen/drawer/course/course_detail_view.dart';
import 'package:skillora/screen/drawer/course/course_view.dart';
import 'package:skillora/screen/drawer/course/lesson/lesson_video_player.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/category_detail_view.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/category_view.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/subcategory_course_view.dart';
import 'package:skillora/screen/drawer/dashboard/home/home_view.dart';
import 'package:skillora/screen/drawer/dashboard/home/popular_course/popular_course_view.dart';
import 'package:skillora/screen/drawer/dashboard/video/video_view.dart';
import 'package:skillora/screen/drawer/drawer_view.dart';
import 'package:skillora/screen/drawer/mentor/instructor_detail_view.dart';
import 'package:skillora/screen/drawer/mentor/instructor_view.dart';
import 'package:skillora/screen/drawer/notification/notification_view.dart';
import 'package:skillora/screen/drawer/setting/account/account_view.dart';
import 'package:skillora/screen/drawer/setting/account/change_password/change_password_view.dart';
import 'package:skillora/screen/drawer/setting/profile/profile_view.dart';
import 'package:skillora/screen/drawer/setting/setting_view.dart';
import 'package:skillora/screen/drawer/setting/support/support_view.dart';
import 'package:skillora/screen/drawer/setting/video_setting/video_setting_view.dart';
import 'package:skillora/screen/drawer/trending/trending_view.dart';
import 'package:skillora/screen/intro/intro_view.dart';
import 'package:skillora/screen/reset_password/create_password_view.dart';
import 'package:skillora/screen/reset_password/forgot_password_view.dart';
import 'package:skillora/screen/signin/signin_view.dart';
import 'package:skillora/screen/signup/signup_view.dart';
import 'package:skillora/screen/splash/splash.dart';
import 'package:skillora/screen/verify_otp/verify_otp_view.dart';

class RoutePath {
  static const String splash = '/splash';
  static const String intro = '/intro';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String createPassword = '/createPassword';
  static const String changePassword = '/changePassword';
  static const String verifyOTP = '/verifyOTP';
  static const String drawer = '/drawer';
  static const String bookmark = '/bookmark';
  static const String home = '/home';
  static const String trending = '/trending';
  static const String instructor = '/instructor';
  static const String instructorDetail = '/instructorDetail';
  static const String setting = '/setting';
  static const String account = '/account';
  static const String profile = '/profile';
  static const String support = '/support';
  static const String lessonVideo = '/lessonVideo';
  static const String videoSetting = '/videoSetting';
  static const String video = '/video';
  static const String notification = '/notification';
  static const String detail = '/detail';
  static const String courseDetail = '/courseDetail';
  static const String category = '/category';
  static const String categoryDetail = '/category_detail';
  static const String subcategory = '/subcategory';
  static const String popularCourse = '/popularCourse';
  static const String course = '/course';

  static appRoutes() => [
        GetPage(
          name: RoutePath.splash,
          page: () => const SplashScreen(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.intro,
          page: () => const IntroView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.signIn,
          page: () => SignInView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.signUp,
          page: () => SignUpView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.forgotPassword,
          page: () => ForgotPasswordView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.createPassword,
          page: () => CreatePasswordView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.verifyOTP,
          page: () => VerifyOTPView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.drawer,
          page: () => DrawerView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.bookmark,
          page: () => const BookmarkView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.home,
          page: () => const HomeView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.trending,
          page: () => const TrendingView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.instructor,
          page: () => InstructorView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.instructorDetail,
          page: () => InstructorDetailView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.setting,
          page: () => SettingView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.account,
          page: () => AccountView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.changePassword,
          page: () => ChangePasswordView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.profile,
          page: () => ProfileView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.support,
          page: () => SupportView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.lessonVideo,
          page: () => LessonVideoPlayer(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.videoSetting,
          page: () => VideoSettingView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.video,
          page: () => const VideoView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.notification,
          page: () => NotificationView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.category,
          page: () => CategoryView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.categoryDetail,
          page: () => CategoryDetailView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.courseDetail,
          page: () => CourseDetailView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.popularCourse,
          page: () => const PopularCourseView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.course,
          page: () => const CourseView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RoutePath.subcategory,
          page: () => const SubCategoryCourseView(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ];
}

class MiddleWare extends GetMiddleware {

  @override
  GetPage? onPageCalled(GetPage? page) {
    debugPrint(page?.name);
    return super.onPageCalled(page);
  }
}
