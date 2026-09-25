import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/model/user_model.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/course/lesson/model/video_model.dart';
import 'package:skillora/services/api_services.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_constants.dart';

class LessonController extends BaseController with ConnectivityMixin {
  PodPlayerController? podController;
  RxList<VideoModel> videoList = <VideoModel>[].obs;
  RxBool isVideoScreen = false.obs;

  String? lessonId;
  bool? isPurchased = false;

  @override
  onInitSetup() async {
    var argument = Get.arguments;
    if (argument != null && argument.containsKey(AppConstants.lessonId)) {
      lessonId = argument[AppConstants.lessonId];
      isPurchased = argument[AppConstants.purchased];

      try {
        changeLoaderStatus(true);
        await getLessonVideo();
      } catch (e) {
        e.printError();
      } finally {
        changeLoaderStatus(false);
      }
    }
  }

  void initPlayerLoader(int index) async {
    if (index >= videoList.length) {
      changeScreen();
      return;
    }

    VideoModel videoModel = videoList[index];

    try {
      if (podController != null) {
        try {
          podController?.pause();
          podController?.dispose();
        } catch (_) {}
        podController = null;
      }

      podController = PodPlayerController(
        podPlayerConfig: const PodPlayerConfig(
          isLooping: false,
          autoPlay: true,
        ),
        playVideoFrom: PlayVideoFrom.network(
          videoModel.video ?? "",
        ),
      );

      podController!.initialise().then((_) {
        if (podController?.videoPlayerValue?.isInitialized ?? false) {
          podController?.play();
        }
      }).catchError((e) {
        changeScreen();
        showMessage(
          translate(
            MyGlobals.navKey.currentContext,
            "common.somethingWentWrong",
          ),
        );
      });

      podController?.addListener(() {
        if (podController?.videoPlayerValue?.isCompleted ?? false) {
          if (isVideoScreen.value == true && checkUserAutoPlay()) {
            playNextVideo(index);
          } else {
            if (isVideoScreen.value == true) {
              stopVideoPlayer(closeVideo: true);
            }
          }
        } else {
          if (isVideoScreen.value == false) {
            stopVideoPlayer(closeVideo: true);
          }
        }
      });
    } catch (e) {
      changeScreen();
      showMessage(
        translate(
          MyGlobals.navKey.currentContext,
          "common.somethingWentWrong",
        ),
      );
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getLessonVideo() async {
    try {
      videoList.clear();
      videoList.value =
          await ApiServices().getLessonVideoList(lessonId ?? "") ?? [];

      // for (VideoModel videoModel in videoList.value) {
      // videoModel.image = await getVideoThumbnail(videoModel.video ?? "");
      // }

      videoList.refresh();
    } catch (e) {
      e.toString();
    }
  }

  // Future<Uint8List?> getVideoThumbnail(String link) async {
  //   try {
  //     return await VideoThumbnail.thumbnailData(
  //       video: link,
  //       imageFormat: ImageFormat.WEBP,
  //       maxHeight: 64,
  //       quality: 75,
  //     );
  //   } catch (e) {
  //     debugPrint("Error generating thumbnail: $e");
  //     return null;
  //   }
  // }

  void changeScreen() {
    isVideoScreen.value = !isVideoScreen.value;
  }

  void stopVideoPlayer({bool closeVideo = false}) {
    try {
      if (podController != null) {
        podController?.pause();
        podController?.removeListener(() {});
        // podController?.dispose();
        // podController = null;
      }
      if (closeVideo && isVideoScreen.value == true) {
        changeScreen();
      }
    } catch (e) {
      e.printError();
    }
  }

  void playNextVideo(int index) {
    index = index + 1;
    stopVideoPlayer();
    initPlayerLoader(index);
  }

  bool checkUserAutoPlay() {
    UserModel? userModel = SharedPreferenceHelper.getUser();
    return userModel?.videoPreferenceModel?.autoplayNextLecture == "1";
  }

  void playVideo(int index) {
    if (isPurchased == false && videoList[index].isPreview == 0) {
      showMessage(
        translate(
          MyGlobals.navKey.currentContext,
          "course.lessons.purchaseFullCourse",
        ),
      );
      return;
    }

    changeScreen();
    initPlayerLoader(index);
  }
}
