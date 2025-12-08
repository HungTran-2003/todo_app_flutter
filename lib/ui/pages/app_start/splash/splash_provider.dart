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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String message = "";

  SplashProvider({
    required this.navigator,
    required this.authRepository,
    required this.todoRepository,
    required this.notificationRepository,
  });

  Future<void> initializeApp() async {
    _setLoading(true, S.current.splash_message_signing_in);
    try {
      await notificationRepository.init();
      final refreshToken = await AppSecureStorage.instance.getRefreshToken();
      if (refreshToken != null) {
        await _handleLoginWithToken(refreshToken);
        return;
      }
      final isFirstRun = await AppSharePreferences.isFirstRun();
      if (isFirstRun) {
        await _handleAnonymousLogin();
        return;
      }
      navigator.openSignIn();
    } catch (e) {
      log('An error occurred during login process: $e');
      navigator.showSnackBar(S.current.error_message_network, Colors.red);
      navigator.openSignIn();
    }
  }

  Future<void> _handleLoginWithToken(String refreshToken) async {
    final user = await authRepository.signInWithToken(refreshToken);
    if (user == null) {
      navigator.showSnackBar(
        S.current.error_message_session_expired,
        Colors.orange,
      );
      navigator.openSignIn();
      return;
    }
    await _fetchDataAndNavigate(user);
  }

  Future<void> _handleAnonymousLogin() async {
    final udid = await DeviceUntil.getUDID();
    final user = await authRepository.signInWithEmail(
      AppUtils.generateDeviceEmail(udid),
      udid,
    );
    if (user == null) {
      navigator.openOnBoardingPage();
      return;
    }
    await AppSharePreferences.setFirstRun(value: false);
    await _fetchDataAndNavigate(user);
  }

  Future<void> _fetchDataAndNavigate(User user) async {
    _updateMessage(S.current.splash_message_fetching_data);
    final todos = await _fetchInitialData();
    _updateMessage(S.current.splash_message_done);
    navigator.openHomePage(todos);
  }

  void _setLoading(bool value, [String msg = ""]) {
    _isLoading = value;
    message = msg;
    notifyListeners();
  }

  void _updateMessage(String msg) {
    message = msg;
    notifyListeners();
  }

  Future<List<TodoEntity>> _fetchInitialData() async {
    final todos = await todoRepository.getTodos();
    final inCompleteTodos = todos
        .where(
          (todo) =>
              todo.isComplete == false && todo.duaDate.isAfter(DateTime.now()),
        )
        .toList();
    await _syncNotifications(inCompleteTodos);
    return todos;
  }

  Future<void> _syncNotifications(List<TodoEntity> todos) async {
    if (todos.isEmpty) return;
    await notificationRepository.cancelAll();
    await notificationRepository.syncTodoNotifications(
      todos,
      S.current.notification_body,
    );
  }
}
