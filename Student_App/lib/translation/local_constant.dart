import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/translation/localization_delegates.dart';

String defaultLanguageCode = 'en';

List<Locale> langArray = [
  const Locale('en', ''),
  const Locale('hi', ''),
  const Locale('gu', ''),
  const Locale('it', ''),
  const Locale('zh', ''),
];

List<String> langCodeArray = ['en', 'hi', 'gu', 'it', 'zh'];

Future<Locale> setLocale(String languageCode) async {
  debugPrint('LangLocal==>$languageCode');
  SharedPreferenceHelper.setLanguage(languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  if (SharedPreferenceHelper.getPrefs() == null) {
    await SharedPreferenceHelper.init();
  }
  String languageCode = SharedPreferenceHelper.getLanguage();
  if (languageCode.isEmpty) {
    languageCode = defaultLanguageCode;
  }
  debugPrint('Lang==>$languageCode');
  return _locale(languageCode);
}

Locale _locale(String? languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale(defaultLanguageCode, '');
}

Future<void> changeLanguage(String selectedLanguageCode) async {
  final locale = await setLocale(selectedLanguageCode);
  await AppLocalizations(locale).load();
  Get.locale = locale;
  if (Get.context != null && !Get.testMode) {
    try {
      Get.updateLocale(locale);
    } catch (_) {}
  }
}