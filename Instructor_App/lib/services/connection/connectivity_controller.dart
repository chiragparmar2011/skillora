import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectionManagerController extends GetxController {
  // 0 = No Internet, 1 = WIFI, 2 = Mobile Data
  RxInt connectionType = 1.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectivityType() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateState(results);
    } on PlatformException catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void _updateState(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      connectionType.value = 1;
    } else if (results.contains(ConnectivityResult.mobile)) {
      connectionType.value = 2;
    } else if (results.contains(ConnectivityResult.none) || results.isEmpty) {
      connectionType.value = 0;
    } else {
      connectionType.value = 1;
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
