import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:todo_app/utils/device_util_info.dart';

import '../../../../repositories/auth_repository.dart';

class SignUpProvider extends ChangeNotifier {
  final SignUpNavigator navigator;
  final AuthRepository authRepository;

  SignUpProvider({required this.navigator, required this.authRepository});

  Future<void> signUp(String email, String password) async {
    navigator.showLoadingOverlay();
    try {
      final udid = await DeviceUntil.getUDID();
      final user = await authRepository.signUp(email, password, udid);
      if (user == null) {
        navigator.showSnackBar(S.current.sign_up_message_failed, Colors.red);
        navigator.hideLoadingOverlay();
        return;
      }
      navigator.showSnackBar(S.current.sign_up_message_success, Colors.green);
      navigator.pop();
    } catch (e) {
      navigator.showSnackBar(S.current.error_message_system, Colors.red);
      navigator.hideLoadingOverlay();
    }
  }
}
