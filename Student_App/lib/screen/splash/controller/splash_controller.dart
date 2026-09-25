import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/model/user_model.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/routes.dart';

class SplashController extends BaseController {
  RxBool firstScreen = true.obs;

  @override
  onInitSetup() {
    Future.delayed(const Duration(seconds: 2), () {
      firstScreen.value = false;
    });

    Future.delayed(const Duration(seconds: 4), () {
      getUserDetail();
    });
  }

  void getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showIntro = prefs.getBool(SharedPreferenceHelper.introDone) ?? false;

    String routePath = RoutePath.intro;
    if (showIntro) {
      if (SharedPreferenceHelper.getUser() != null) {
        try {
          UserModel? model = await apiServices.getUserDetails();
          if (model != null) {
            SharedPreferenceHelper.setUser(model);
          }
        } catch (e) {
          showError(e.toString());
        }

        routePath = RoutePath.drawer;
      } else {
        routePath = RoutePath.signIn;
      }
    }

    Get.offAllNamed(routePath);
  }
}
