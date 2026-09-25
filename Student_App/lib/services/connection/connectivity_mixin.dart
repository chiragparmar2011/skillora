import 'package:get/get.dart';
import 'package:skillora/services/connection/connectivity_controller.dart';

mixin ConnectivityMixin on GetxController {
  ConnectionManagerController get connectivityController =>
      Get.put(ConnectionManagerController());

  bool get isInternetConnected =>
      connectivityController.connectionType.value == 0;
}
