import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/controller/course_controller.dart';
import 'package:skillora/screen/drawer/course/course_screen_widget.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/translation/localization_delegates.dart';

class PopularCourseView extends StatelessWidget {
  const PopularCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return CourseScreenWidget(
      title: translate(
          MyGlobals.navKey.currentContext, 'course.mostPopularCourse'),
      controller: Get.put(CourseController(), tag: RoutePath.popularCourse),
    );
  }
}
