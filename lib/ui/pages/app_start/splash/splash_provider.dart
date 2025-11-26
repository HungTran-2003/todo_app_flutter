import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/database/app_share_preferences.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_navigator.dart';

class SplashProvider extends ChangeNotifier {
  final SplashNavigator navigator;
  final _auth = AuthService();
  final _todo = TodoService();

  bool isLoading = false;
  String message = "";

  SplashProvider({required this.navigator});

  Future<void> checkFirstRun() async {
    final isFirstRun = await AppSharePreferences.isFirstRun();
    log(isFirstRun.toString());
    if (isFirstRun) {
      await navigator.openOnBoardingPage();
    } else {
      await _fetchInitialData();
    }
  }

  Future<void> _fetchInitialData() async {
    isLoading = true;
    message = "Signing in";
    notifyListeners();
    final isLogin = await _checkLogin();
    if (isLogin) {
      try {
        message = "Fetching data";
        notifyListeners();
        final todos = await _todo.getTodos();
        log(todos.length.toString());
        message = "Success";
        await Future.delayed(const Duration(seconds: 1));
        navigator.openHomePage(todos);
      } catch (e) {
        log(e.toString());
        message = e.toString();
      }
    } else {
      message = "Login failed";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> _checkLogin() async {
    final isLogin = await _auth.signInWithDeviceId() != null;
    return isLogin;
  }
}
