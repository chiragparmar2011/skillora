import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class InternetStatus {
  InternetStatus._internal();

  //This creates the single instance by calling the `_internal` constructor specified below
  static final InternetStatus _singleton = InternetStatus._internal();

  //This is what's used to retrieve the instance through the app
  static InternetStatus getInstance() => _singleton;

  //This tracks the current connection status
  static bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes

  static final BehaviorSubject<bool> connectionChangeController =
      BehaviorSubject<bool>();

  //flutter_connectivity
  static final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  Future<void> initialize() async {
    final List<ConnectivityResult> connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      hasConnection = true;
    } else {
      hasConnection = false;
    }
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    debugPrint('Internet listener initialized');
  }

  Stream<bool> get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  void _connectionChange(List<ConnectivityResult> result) {
    checkConnection(result);
  }

  Future<bool> checkConnection(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      hasConnection = true;
    } else {
      hasConnection = false;
    }
    connectionChangeController.sink.add(hasConnection);

    return hasConnection;
  }
}
