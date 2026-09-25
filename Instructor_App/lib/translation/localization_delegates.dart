import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instructor_app/translation/local_constant.dart';

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

  dynamic _getNestedValue(String key) {
    final Map keyMap = key.split('.').asMap();
    dynamic nestedValue;
    keyMap.forEach((index, k) {
      if (index == 0) {
        nestedValue = language?[k];
      } else {
        nestedValue = (nestedValue is Map) ? nestedValue[k] : '';
      }
    });
    return nestedValue;
  }

  Future<bool> load() async {
    try {
      String string = await rootBundle
          .loadString("assets/json/${locale.languageCode}.json");
      language = json.decode(string);
      return true;
    } catch (_) {
      try {
        String fallbackString =
            await rootBundle.loadString("assets/json/en.json");
        language = json.decode(fallbackString);
        return true;
      } catch (_) {
        return false;
      }
    }
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

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
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
