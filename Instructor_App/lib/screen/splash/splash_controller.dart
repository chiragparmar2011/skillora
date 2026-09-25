import 'dart:async';
import 'package:get/get.dart';
import 'package:instructor_app/helper/shared_preference_helper.dart';
import 'package:instructor_app/screen/base_controller.dart';
import 'package:instructor_app/screen/routes.dart';

class SplashController extends BaseController {
  RxBool firstScreen = true.obs;
  Timer? _phaseTimer;
  Timer? _navTimer;

  @override
  void onInitSetup() {
    startTimer();
  }

  void startTimer() {
    // Phase 1 to Phase 2 transition at 1.8 seconds
    _phaseTimer = Timer(const Duration(milliseconds: 1800), () {
      firstScreen.value = false;
    });

    // Navigation at 3.2 seconds
    _navTimer = Timer(const Duration(milliseconds: 3200), () {
      bool isLoggedIn = SharedPreferenceHelper.isLoggedIn();
      if (isLoggedIn) {
        navigateTo(RoutePath.dashboard, isClearAll: true);
      } else {
        navigateTo(RoutePath.signIn, isClearAll: true);
      }
    });
  }

  @override
  void onClose() {
    _phaseTimer?.cancel();
    _navTimer?.cancel();
    super.onClose();
  }
}
