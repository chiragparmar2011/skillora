import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/screen/drawer/course/controller/course_controller.dart';
import 'package:skillora/screen/drawer/course/course_screen_widget.dart';
import 'package:skillora/screen/routes.dart';

class VideoView extends StatelessWidget {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return CourseScreenWidget(
      title: '',
      controller: Get.put(CourseController(), tag: RoutePath.video),
      downloadView: true,
    );
  }
}
