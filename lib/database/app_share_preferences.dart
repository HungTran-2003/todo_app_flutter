import 'package:shared_preferences/shared_preferences.dart';

class AppSharePreferences {
  static const _firstRunKey = "first_run";

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
}
