import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/controller/course_controller.dart';
import 'package:skillora/screen/drawer/course/course_screen_widget.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/translation/localization_delegates.dart';

class BookmarkView extends GetView<CourseController> {
  final VoidCallback? onBackPressed;
  final bool isHideBack;
  final bool isHideAppBar;

  const BookmarkView({
    this.onBackPressed,
    this.isHideBack = false,
    this.isHideAppBar = false,
    super.key,
  });

  @override
  String? get tag => RoutePath.bookmark;

  @override
  CourseController get controller {
    if (!Get.isRegistered<CourseController>(tag: tag)) {
      final courseController = Get.put(CourseController(), tag: tag);
      courseController.isBookmark = true;
      courseController.onInitSetup();
      return courseController;
    }
    return Get.find<CourseController>(tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return CourseScreenWidget(
      title: translate(MyGlobals.navKey.currentContext, 'drawer.wishlist'),
      controller: controller,
      onBackPressed: onBackPressed,
      isHideBack: isHideBack,
      isHideAppBar: isHideAppBar,
    );
  }
}
