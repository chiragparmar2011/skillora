import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/controller/course_controller.dart';
import 'package:skillora/screen/drawer/course/course_screen_widget.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/translation/localization_delegates.dart';

class CourseView extends GetView<CourseController> {
  const CourseView({this.title, super.key});
  final String? title;

  @override
  String? get tag => RoutePath.course;

  @override
  CourseController get controller {
    if (!Get.isRegistered<CourseController>(tag: tag)) {
      return Get.put(CourseController(), tag: tag);
    }
    return Get.find<CourseController>(tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return CourseScreenWidget(
      title: title ??
          translate(
            MyGlobals.navKey.currentContext,
            'course.course',
          ),
      controller: controller,
    );
  }
}
