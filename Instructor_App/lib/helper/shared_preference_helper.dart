import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:instructor_app/utilities/app_constants.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setBool(String key, bool value) async =>
      await _preferences?.setBool(key, value);

  static bool getBool(String key) => _preferences?.getBool(key) ?? false;

  static Future setString(String key, String value) async =>
      await _preferences?.setString(key, value);

  static String getString(String key) => _preferences?.getString(key) ?? '';

  static Future setStringList(String key, List<String> value) async =>
      await _preferences?.setStringList(key, value);

  static List<String> getStringList(String key) =>
      _preferences?.getStringList(key) ?? [];

  static Future remove(String key) async => await _preferences?.remove(key);

  static Future clear() async => await _preferences?.clear();

  // Auth & Token
  static Future setAuthToken(String token) async =>
      await setString(AppConstants.authToken, token);

  static String getAuthToken() => getString(AppConstants.authToken);

  static bool isLoggedIn() => getAuthToken().isNotEmpty;

  // Language
  static Future setLanguage(String lang) async =>
      await setString(AppConstants.languageKey, lang);

  static String getLanguage() {
    String l = getString(AppConstants.languageKey);
    return l.isNotEmpty ? l : 'en';
  }

  // Instructor User Info
  static Future setInstructorInfo(Map<String, dynamic> data) async =>
      await setString(AppConstants.instructorInfo, jsonEncode(data));

  static Map<String, dynamic>? getInstructorInfo() {
    String str = getString(AppConstants.instructorInfo);
    if (str.isEmpty) return null;
    try {
      return jsonDecode(str) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  // Digital Signature Path
  static Future setDigitalSignature(String signature) async =>
      await setString(AppConstants.digitalSignature, signature);

  static String getDigitalSignature() =>
      getString(AppConstants.digitalSignature);
}
