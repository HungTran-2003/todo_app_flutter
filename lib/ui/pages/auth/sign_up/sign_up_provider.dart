import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:todo_app/utils/device_util_info.dart';

class SignUpProvider extends ChangeNotifier {
  final SignUpNavigator navigator;

  SignUpProvider({required this.navigator});

  Future<void> signUp(String email, String password) async {
    navigator.showLoadingOverlay();
    try {
      final udid = await DeviceUntil.getUDID();
      final user = await AuthService.instance.signUp(email, password, udid);
      if (user == null) {
        navigator.showSnackBar("Sign up failed", Colors.red);
        return;
      }
      navigator.showSnackBar("Sign up successful", Colors.green);
      navigator.pop();
    } catch (e) {
      navigator.showSnackBar("System Error", Colors.red);
    }
  }
}
