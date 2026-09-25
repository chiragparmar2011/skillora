import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillora/model/user_model.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _preferences;

  static String authToken = 'authToken';
  static String fcmToken = 'fcmToken';
  static String userInfo = 'userInfo';
  static String introDone = 'introDone';

  static String languageKey = 'languageKey';

  static SharedPreferences? getPrefs() {
    return _preferences;
  }

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setBool(String key, bool value) async =>
      await _preferences?.setBool(key, value);

  static Future setDouble(String key, double value) async =>
      await _preferences?.setDouble(key, value);

  static Future setInt(String key, int value) async =>
      await _preferences?.setInt(key, value);

  static Future setString(String key, String value) async =>
      await _preferences?.setString(key, value);

  static Future setStringList(String key, List<String> value) async =>
      await _preferences?.setStringList(key, value);

  static bool getBool(String key) {
    final value = _preferences?.getBool(key);
    if (value == null) {
      return false;
    }
    return value;
  }

  static double getDouble(String key) {
    final value = _preferences?.getDouble(key);
    if (value == null) {
      return 0;
    }
    return value;
  }

  static int getInt(String key) {
    final value = _preferences?.getInt(key);
    if (value == null) {
      return 0;
    }
    return value;
  }

  static String getString(String key) {
    final value = _preferences?.getString(key);
    if (value == null) {
      return '';
    }
    return value;
  }

  static List<String> getStringList(String key) {
    return _preferences?.getStringList(key) ?? [];
  }

  static Future remove(String key) async => await _preferences?.remove(key);

  static Future clear() async => await _preferences?.clear();

  static const String followedInstructorsKey = 'followed_instructors';

  static List<String> getFollowedInstructors() {
    return getStringList(followedInstructorsKey);
  }

  static bool isInstructorFollowed(int instructorId) {
    return getFollowedInstructors().contains(instructorId.toString());
  }

  static Future<bool> toggleFollowInstructor(int instructorId) async {
    if (_preferences == null) {
      await init();
    }
    List<String> list = List.from(getFollowedInstructors());
    String idStr = instructorId.toString();
    bool isNowFollowed = false;
    if (list.contains(idStr)) {
      list.remove(idStr);
      isNowFollowed = false;
    } else {
      list.add(idStr);
      isNowFollowed = true;
    }
    await setStringList(followedInstructorsKey, list);
    return isNowFollowed;
  }

  static String _courseLessonsKey(int courseId) =>
      'completed_lessons_$courseId';

  static List<String> getCompletedLessons(int courseId) {
    return getStringList(_courseLessonsKey(courseId));
  }

  static bool isLessonCompleted(int courseId, int lessonId) {
    return getCompletedLessons(courseId).contains(lessonId.toString());
  }

  static Future<bool> toggleLessonCompleted(int courseId, int lessonId) async {
    if (_preferences == null) {
      await init();
    }
    List<String> list = List.from(getCompletedLessons(courseId));
    String idStr = lessonId.toString();
    bool isNowCompleted = false;
    if (list.contains(idStr)) {
      list.remove(idStr);
      isNowCompleted = false;
    } else {
      list.add(idStr);
      isNowCompleted = true;
    }
    await setStringList(_courseLessonsKey(courseId), list);
    return isNowCompleted;
  }

  static void setUser(UserModel? userModel) {
    if (userModel != null) {
      _preferences?.setString(userInfo, jsonEncode(userModel));
    }
  }

  static UserModel? getUser() {
    final value = _preferences?.getString(userInfo);
    if (value == null) {
      return null;
    }
    return UserModel.fromJson(jsonDecode(value));
  }

  static void setLanguage(String langKey) {
    _preferences?.setString(languageKey, langKey);
  }

  static String getLanguage() {
    String? langCode = getString(languageKey);
    if (langCode.isNotEmpty) {
      return langCode;
    }
    return 'en';
  }

// static void setAppSettingInfo(AppSettingModel? settingModel) {
//   if (settingModel != null) {
//     _preferences?.setString(appSetting, jsonEncode(settingModel));
//   }
// }
//
// static List<AppSettingModel>? getAppSettingInfo() {
//   final value = _preferences?.getString(appSetting);
//   if (value == null) {
//     return null;
//   }
//
//   List<dynamic> model = jsonDecode(value);
//   List<AppSettingModel> settingModel =
//       model.map((e) => AppSettingModel.fromJson(e)).toList();
//   return settingModel;
// }
//
// static String? getAppSettingValue({String? settingType}) {
//   int len = getAppSettingInfo()?.length ?? 0;
//   String? value;
//   for (int i = 0; i < len; i++) {
//     if (getAppSettingInfo()?[i].settingKey == settingType) {
//       value = getAppSettingInfo()?[i].settingValue;
//       break;
//     }
//   }
//   return value;
// }
//

  static Future<void> logout() async {
    remove(authToken);
    remove(userInfo);
    // remove(appSetting);
  }

  static void setAuthToken(String? token) {
    if (token != null) {
      _preferences?.setString(authToken, 'Bearer $token');
    }
  }

  static String getAuthToken() {
    return getString(authToken);
  }

  static void setFcmToken(String? token) {
    if (token != null) {
      _preferences?.setString(fcmToken, token);
    }
  }

  static String getFcmToken() {
    String fcmToken = getString('fcmToken');
    return fcmToken.isNotEmpty ? fcmToken : 'FCMTOKEN';
  }
}
