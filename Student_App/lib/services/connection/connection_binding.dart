import 'package:get/get.dart';
import 'package:skillora/services/connection/connectivity_controller.dart';

class ConnectivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectionManagerController);
  }
}
