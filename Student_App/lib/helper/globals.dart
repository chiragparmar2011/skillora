import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

MyGlobals myGlobals = MyGlobals();

Logger logger = Logger(
  output: MultiOutput([ConsoleOutput()]),
  printer: PrettyPrinter(
    errorMethodCount: 5,
    lineLength: 150,
    methodCount: 3,
    printTime: true,
    excludeBox: {Level.trace: false},
  ),
);

void initializeLogger() async {
  // final Directory directory = await getApplicationSupportDirectory();
  // const String fileName = 'error_log.txt';
  // final String finalPath = join(directory.path, fileName);
  // debugPrint('final pATH $finalPath');
  // logger = Logger(
  //   output: MultiOutput([ConsoleOutput(),FileOutput(file:File(finalPath))]),
  // );
  //
  // logger.d('LOGGER FILE CREATED AT:- $finalPath');
}

class MyGlobals {
  factory MyGlobals() {
    // initializeLogger();
    return _myGlobals;
  }

  MyGlobals._internal();

  static final MyGlobals _myGlobals = MyGlobals._internal();

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
}
