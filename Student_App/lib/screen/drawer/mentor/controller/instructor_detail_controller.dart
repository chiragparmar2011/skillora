import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/services/api_services.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_constants.dart';
import 'package:skillora/utilities/app_utils.dart';

class InstructorDetailController extends BaseController with ConnectivityMixin {
  Rx<InstructorModel?> instructorModel = InstructorModel().obs;
  bool isBookmark = false;
  RxBool isFollowed = false.obs;
  RxInt studentCount = 0.obs;
  RxBool isFollowLoading = false.obs;

  @override
  onInitSetup() {
    var argument = Get.arguments;
    if (argument != null && argument is Map) {
      if (argument.containsKey('instructorId') && argument['instructorId'] != null) {
        int instructorId = argument['instructorId'] as int;
        getSingleInstructor(instructorId);
      } else {
        getSingleInstructor(1);
      }
      if (argument.containsKey(AppConstants.isBookmark)) {
        isBookmark = argument[AppConstants.isBookmark] ?? false;
      }
    } else {
      getSingleInstructor(1);
    }
  }

  void getSingleInstructor(int instructorId) async {
    try {
      changeLoaderStatus(true);
      instructorModel.value =
          await apiServices.getSingleInstructor(instructorId);
      int actualId = instructorModel.value?.id ?? instructorId;
      isFollowed.value =
          SharedPreferenceHelper.isInstructorFollowed(actualId);
      studentCount.value = instructorModel.value?.student ?? 0;
    } catch (e) {
      debugPrint("Error fetching instructor: $e");
    }
    changeLoaderStatus(false);
  }

  Future<void> toggleFollow() async {
    if (isFollowLoading.value) return;
    int? instructorId = instructorModel.value?.id;
    if (instructorId == null) return;
    try {
      isFollowLoading.value = true;
      bool nowFollowed =
          await SharedPreferenceHelper.toggleFollowInstructor(instructorId);
      isFollowed.value = nowFollowed;
      await apiServices.followInstructor(instructorId, nowFollowed);

      if (nowFollowed) {
        studentCount.value += 1;
        instructorModel.value?.student = studentCount.value;
        String name = getFirstName();
        String msg = translate(
          MyGlobals.navKey.currentContext,
          'instructor.nowFollowing',
        ).replaceAll('{name}', name);
        showSuccess(msg);
      } else {
        if (studentCount.value > 0) studentCount.value -= 1;
        instructorModel.value?.student = studentCount.value;
        String name = getFirstName();
        String msg = translate(
          MyGlobals.navKey.currentContext,
          'instructor.unfollowed',
        ).replaceAll('{name}', name);
        showSuccess(msg);
      }
      instructorModel.refresh();
    } catch (e) {
      debugPrint("Error toggling follow: $e");
    } finally {
      isFollowLoading.value = false;
    }
  }

  String getImage() {
    return instructorModel.value?.image ?? AppUtils().getDefaultImage();
  }

  String getFirstName() {
    return instructorModel.value?.firstName ?? '';
  }

  String getDesignation() {
    return instructorModel.value?.designation ?? '';
  }

  int getStudent() {
    return instructorModel.value?.student ?? 0;
  }

  int getReview() {
    return instructorModel.value?.review ?? 0;
  }

  String getAbout() {
    return instructorModel.value?.aboutMe ?? '';
  }

  String getWebLink() {
    return instructorModel.value?.webLink ?? '';
  }

  String getFacebookLink() {
    return instructorModel.value?.facebookLink ?? '';
  }

  String getInstagramLink() {
    return instructorModel.value?.instagramLink ?? '';
  }

  void onTapBookMark(int index) {
    bookmarkCourse(index);
    instructorModel.refresh();
  }

  void bookmarkCourse(int index) async {
    try {
      Map<String, dynamic> dataRequest = {};
      dataRequest.addAll({
        'course_id': instructorModel.value?.course?[index].id.toString(),
        'user_type': AppConstants.user,
      });
      bool? data = await ApiServices().bookmarkCourse(dataRequest);
      if (isBookmark) {
        if (data == false) {
          instructorModel.value?.course?.removeAt(index);
        }
      } else {
        instructorModel.value?.course?[index].wishlistSet = data;
      }
      instructorModel.refresh();
    } catch (e) {
      e.toString();
    }
  }

  void openCourseDetail(CourseModel? course) {
    navigateTo(
      RoutePath.courseDetail,
      data: {
        'courseId': course?.id,
      },
    );
  }
}
