import 'package:shared_preferences/shared_preferences.dart';

class AppSharePreferences {
  static const _firstRunKey = "first_run";
  static const _isFirstLoginKey = "is_first_login";

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

  static Future<bool> isFirstLogin() async {
    return _prefs.getBool(_isFirstLoginKey) ?? false;
  }

  static Future<void> setFirstLogin({bool value = true}) async {
    setFirstRun();
    _prefs.setBool(_isFirstLoginKey, value);
  }
}
