import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/enum/language.dart';

class AppSharePreferences {
  static const _firstRunKey = "first_run";
  static const _currentLanguageKey = 'current_language';

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> isFirstRun() async {
    return _prefs.getBool(_firstRunKey) ?? true;
  }

  static Future<void> setFirstRun({bool value = true}) async {
    _prefs.setBool(_firstRunKey, value);
  }

  static Future<Language?> getCurrentLanguage() async {
    try {
      final languageCode = _prefs.getString(_currentLanguageKey) ?? "";
      return Language.languageFromCode(languageCode);
    } catch (e) {
      return null;
    }
  }

  static Future<void> setCurrentLanguage(Language language) async {
    await _prefs.setString(_currentLanguageKey, language.code);
  }
}
