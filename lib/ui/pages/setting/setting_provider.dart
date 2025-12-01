import 'package:flutter/cupertino.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/ui/pages/setting/setting_navigator.dart';

class SettingProvider extends ChangeNotifier {
  final SettingNavigator navigator;
  final AuthRepository authRepository;


  SettingProvider({required this.navigator, required this.authRepository});

  Future<void> logout() async {
    await authRepository.signOut();
    navigator.openSignIn();
  }
}
