import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/database/app_share_preferences.dart';
import 'package:todo_app/router/router_config.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/onboarding_navigator.dart';

class OnboardingProvider extends ChangeNotifier {
  final OnboardingNavigator navigator;
  final _auth = AuthService();

  final List<String> pages = [
    AppRouter.login,
    AppRouter.register,
    AppRouter.home,
  ];

  OnboardingProvider({required this.navigator});

  void nextPage(int index) async {
    await _setIsFirstRun();
    switch (index) {
      case 0:
        log("login");
        break;
      case 1:
        log("register");
        break;
      case 2:
        log("home");
        await _loginAnonymously();
        break;
      default:
        log("default");
        break;
    }
  }

  Future<void> _setIsFirstRun() async {
    try {
      await AppSharePreferences.setFirstRun(value: false);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _loginAnonymously() async {
    navigator.showLoadingOverlay();
    try {
      final user = await _auth.signInWithDeviceId();
      if (user == null) {
        log("user is null");
      } else {
        log(user.id);
      }
      await navigator.openHomePage();
    } catch (e) {
      log(e.toString());
    }
  }
}
