import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/database/app_share_preferences.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_navigator.dart';

class SplashProvider extends ChangeNotifier {
  final SplashNavigator navigator;
  final TodoProvider todoProvider;

  bool isLoading = false;
  String message = "";

  SplashProvider({required this.todoProvider, required this.navigator});

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
        await Future.delayed(const Duration(seconds: 1));
        message = "Success";
        todoProvider.setTodos(TodoEntity.mockData);
        await Future.delayed(const Duration(seconds: 1));
        navigator.openHomePage();
      } catch (e) {
        message = e.toString();
      }
    } else {
      message = "Login failed";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> _checkLogin() async {
    final isLogin = true;
    await Future.delayed(const Duration(seconds: 1));
    return isLogin;
  }
}
