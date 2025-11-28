import 'package:flutter/cupertino.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/ui/pages/setting/setting_navigator.dart';

class SettingProvider extends ChangeNotifier {
  final SettingNavigator navigator;

  SettingProvider({required this.navigator});

  Future<void> logout() async {
    await AuthService.instance.signOut();
    navigator.openSignIn();
  }
}
