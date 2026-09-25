import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/model/user_model.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/utilities/app_constants.dart';

class SettingController extends BaseController with ConnectivityMixin {
  UserModel? user;

  void navigateToProfile() {
    navigateTo(RoutePath.profile);
  }

  void navigateToVideoSetting() {
    navigateTo(RoutePath.videoSetting);
  }

  void navigateToAccount() {
    navigateTo(RoutePath.account);
  }

  void navigateToSupport() {
    navigateTo(RoutePath.support);
  }

  @override
  onInitSetup() {
    fetchUserData();
  }

  void fetchUserData() {
    user = SharedPreferenceHelper.getUser();
  }

  bool getAutoPlayLecture() {
    if (user != null) {
      if (user?.videoPreferenceModel?.autoplayNextLecture == '1') {
        return true;
      }
    }
    return false;
  }

  void changAutoPlayLecture() async {
    try {
      Map<String, dynamic> data = {
        'user_type': AppConstants.user,
        'download_wifi': '1',
        'before_download_resourse': '1',
        'autoplay_next_lecture': getAutoPlayLecture() ? '2' : '1',
        'play_background': '1',
      };

      String? autoPlay = await apiServices.changeAutoPlay(data);
      user?.videoPreferenceModel?.autoplayNextLecture = autoPlay ?? '1';
      SharedPreferenceHelper.setUser(user);
    } catch (e) {
      showError(e.toString());
    }
  }
}
