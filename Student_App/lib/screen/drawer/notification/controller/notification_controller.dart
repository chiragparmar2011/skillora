import 'package:get/get.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/notification/model/notification_model.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';

class NotificationController extends BaseController with ConnectivityMixin {
  RxMap<String, List<NotificationModel>> notificationList = <String, List<NotificationModel>>{}.obs;

  void getNotifications() async {
    try {
      changeLoaderStatus(true);
      Map<String, List<NotificationModel>>? apiResponse = await apiServices.getNotification();
      if (apiResponse!.isNotEmpty) {
        notificationList.assignAll(apiResponse);
      }
    } catch (e) {
      e.toString();
    }
    changeLoaderStatus(false);
  }

  @override
  onInitSetup() {
    getNotifications();
  }
}
