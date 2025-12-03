import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/database/app_secure_storage.dart';
import 'package:todo_app/database/app_share_preferences.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/repositories/notification_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_navigator.dart';
import 'package:todo_app/utils/device_util_info.dart';
import 'package:todo_app/utils/utils.dart';

class SplashProvider extends ChangeNotifier {
  final SplashNavigator navigator;
  final AuthRepository authRepository;
  final TodoRepository todoRepository;
  final NotificationRepository notificationRepository;

  bool isLoading = false;
  String message = "";

  SplashProvider({required this.navigator, required this.authRepository, required this.todoRepository, required this.notificationRepository});

  Future<void> login() async {
    isLoading = true;
    message = S.current.splash_message_signing_in;
    log(message);
    notifyListeners();
    try {
      final refreshToken = await AppSecureStorage.instance.getRefreshToken();
      User? user;

      if (refreshToken != null) {
        user = await authRepository.signInWithToken(refreshToken);
        if (user == null) {
          navigator.showSnackBar(S.current.error_message_session_expired, Colors.orange);
          navigator.openSignIn();
          return;
        }
      } else {
        final isFirstLogin = await AppSharePreferences.isFirstLogin();
        log("isFirstLogin: $isFirstLogin");
        if (isFirstLogin) {
          navigator.openSignIn();
          return;
        } else {
          final udid = await DeviceUntil.getUDID();
          user = await authRepository.signInWithEmail(
            AppUtils.generateDeviceEmail(udid),
            udid,
          );
          if (user != null) {
            await AppSharePreferences.setFirstRun(value: false);
          } else {
            navigator.openOnBoardingPage();
            return;
          }
        }
      }

      message = S.current.splash_message_fetching_data;
      notifyListeners();
      final todos = await _fetchInitialData();

      message = S.current.splash_message_done;
      notifyListeners();
      navigator.openHomePage(todos);
    } catch (e) {
      log('An error occurred during login process: $e');
      navigator.showSnackBar(S.current.error_message_network, Colors.red);
      navigator.openSignIn();
    }
  }

  Future<List<TodoEntity>> _fetchInitialData() async {
    final todos = await todoRepository.getTodos();
    return todos;
  }
}
