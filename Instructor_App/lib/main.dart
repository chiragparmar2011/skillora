import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:instructor_app/helper/globals.dart';
import 'package:instructor_app/helper/shared_preference_helper.dart';
import 'package:instructor_app/screen/routes.dart';
import 'package:instructor_app/translation/local_constant.dart';
import 'package:instructor_app/translation/localization_delegates.dart';
import 'package:instructor_app/utilities/app_colors.dart';
import 'package:instructor_app/utilities/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.init();
  Locale initialLocale = await getLocale();
  runApp(SkilloraInstructorApp(initialLocale: initialLocale));
}

class SkilloraInstructorApp extends StatelessWidget {
  final Locale initialLocale;
  const SkilloraInstructorApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: MyGlobals.navKey,
      locale: initialLocale,
      supportedLocales: langArray,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Roboto",
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.bgColorWhite,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          primary: AppColors.primaryColor,
        ),
      ),
      initialRoute: RoutePath.splash,
      getPages: AppPages.routes,
    );
  }
}
