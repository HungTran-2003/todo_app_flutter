import 'package:flutter/cupertino.dart';
import 'package:todo_app/database/app_share_preferences.dart';
import 'package:todo_app/ui/pages/setting/setting_navigator.dart';

class SettingProvider extends ChangeNotifier {
  final SettingNavigator navigator;

  SettingProvider({required this.navigator});

  Future<void> logout() async {
    await AppSharePreferences.setLogin(value: false);
    navigator.openSignIn();
  }
}