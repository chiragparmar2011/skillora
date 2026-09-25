import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skillora/translation/local_constant.dart';

Map<String, dynamic>? language;

String translate(BuildContext? context, String key) {
  if (context != null) {
    String? val = AppLocalizations.of(context)?.translate(key);
    if (val != null && val.isNotEmpty && val != key) return val;
  }
  if (language != null) {
    final Map keyMap = key.split('.').asMap();
    dynamic nestedMap;
    keyMap.forEach((index, k) {
      if (index == 0) {
        nestedMap = language?[k];
      } else {
        nestedMap = (nestedMap is Map) ? nestedMap[k] : '';
      }
    });
    if (nestedMap != null && nestedMap.toString().isNotEmpty) {
      return nestedMap.toString();
    }
  }
  return key;
}

class AppLocalizations {
  AppLocalizations(this.locale);
  Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String? translate(String key) {
    final nestedMap = _getNestedValue(key);
    return nestedMap?.toString();
  }

  dynamic translatedLanguagesList(String key) {
    final Map keyMap = key.split('.').asMap();
    dynamic nestedMap;
    keyMap.forEach((index, key) {
      if (index == 0) {
        nestedMap = language?[key];
      } else {
        nestedMap = nestedMap[key] ?? '';
      }
    });
    return nestedMap;
  }

  dynamic _getNestedValue(String keyPath) {
    final Map keyMap = keyPath.split('.').asMap();
    dynamic nestedMap;
    keyMap.forEach((index, key) {
      if (index == 0) {
        nestedMap = language?[key];
      } else {
        nestedMap = (nestedMap is Map) ? nestedMap[key] : '';
        if (nestedMap == null || nestedMap.toString() == '') {
          // debugPrint('Translate key---> $key $keyPath <--- is null');
        }
      }
    });
    return nestedMap;
  }

  Future<bool> load() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/${locale.languageCode}.json',
      );
      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;
      language = jsonMap;
      return true;
    } catch (_) {
      try {
        final String fallbackString =
            await rootBundle.loadString('assets/json/en.json');
        language = jsonDecode(fallbackString) as Map<String, dynamic>;
        return true;
      } catch (_) {
        return false;
      }
    }
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return langCodeArray.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}
