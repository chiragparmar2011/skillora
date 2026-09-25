import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/translation/local_constant.dart';
import 'package:skillora/translation/localization_delegates.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await SharedPreferenceHelper.init();
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  test('All 5 language JSON assets can be loaded and translated', () async {
    for (final code in ['en', 'hi', 'gu', 'it', 'zh']) {
      final loc = Locale(code, '');
      final appLoc = AppLocalizations(loc);
      final loaded = await appLoc.load();
      expect(loaded, isTrue, reason: 'Failed loading for language code: $code');

      final saveText = appLoc.translate('common.save');
      expect(saveText, isNotNull);

      if (code == 'en') expect(saveText, 'Save');
      if (code == 'hi') expect(saveText, '\u0938\u0939\u0947\u091C\u0947\u0902');
      if (code == 'gu') expect(saveText, '\u0AB8\u0ABE\u0A9A\u0AB5\u0ACB');
      if (code == 'it') expect(saveText, 'Salva');
      if (code == 'zh') expect(saveText, '\u4FDD\u5B58');
    }
  });

  test('changeLanguage switches active locale and dictionary', () async {
    await changeLanguage('it');
    expect(translate(null, 'common.save'), 'Salva');

    await changeLanguage('zh');
    expect(translate(null, 'common.save'), '\u4FDD\u5B58');

    await changeLanguage('hi');
    expect(translate(null, 'common.save'), '\u0938\u0939\u0947\u091C\u0947\u0902');

    await changeLanguage('gu');
    expect(translate(null, 'common.save'), '\u0AB8\u0ABE\u0A9A\u0AB5\u0ACB');

    await changeLanguage('en');
    expect(translate(null, 'common.save'), 'Save');
  });
}