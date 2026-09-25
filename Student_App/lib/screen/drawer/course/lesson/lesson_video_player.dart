
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/lesson/controller/lesson_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class LessonVideoPlayer extends StatelessWidget {
  LessonVideoPlayer({super.key});

  final LessonController controller =
      Get.put(LessonController(), tag: RoutePath.lessonVideo);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (controller.podController != null) {
          controller.podController?.pause();
          controller.podController?.dispose();
          controller.podController = null;
          controller.changeScreen();
        } else {
          Get.back();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColorWhite,
        body: SafeArea(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VAAppBar(
                    appBarTitle: (controller.isVideoScreen.value == true)
                        ? ""
                        : translate(
                            MyGlobals.navKey.currentContext,
                            'course.lessons.lessonVideo',
                          ),
                    onBackPressed: () {
                      if (controller.isVideoScreen.value == true) {
                        controller.stopVideoPlayer(closeVideo: true);
                      } else {
                        Get.back();
                      }
                    }),
                Expanded(
                  child: (controller.isVideoScreen.value)
                      ? getVideoPlayerWidget()
                      : _buildBody(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (controller.isInternetConnected) {
      return const VANoInternetAsset();
    }
    if (controller.isLoading.value) {
      return const VALoader();
    }

    if (controller.videoList.isEmpty) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.video_library_outlined,
                size: 72,
                color: AppColors.darkGray,
              ),
            ),
            Text(
              translate(
                MyGlobals.navKey.currentContext,
                'course.lessons.noVideo',
              ),
              style: TextStyles().textStyleRoboto(
                fontSize: 18,
                color: AppColors.mentorAbout,
              ),
            ),
          ],
        ),
      );
    }
    return _buildVideoWidget();
  }

  Widget getVideoPlayerWidget() {
    if (controller.podController == null) {
      return const Center(child: VALoader());
    }
    return PodVideoPlayer(
      alwaysShowProgressBar: true,
      controller: controller.podController!,
    );
  }

  Widget _buildVideoWidget() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: controller.videoList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            controller.playVideo(index);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.platinumBorder),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.dropShadowColor,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    controller.videoList[index].name ?? '',
                    style: TextStyles().textStyleRoboto(
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
