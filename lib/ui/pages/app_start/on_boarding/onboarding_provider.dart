import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/database/app_share_preferences.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/router/router_config.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/onboarding_navigator.dart';
import 'package:todo_app/utils/device_util_info.dart';
import 'package:todo_app/utils/utils.dart';

class OnboardingProvider extends ChangeNotifier {
  final OnboardingNavigator navigator;
  final AuthRepository authRepository;

  final List<String> pages = [
    AppRouter.login,
    AppRouter.register,
    AppRouter.home,
  ];

  OnboardingProvider({required this.navigator, required this.authRepository});

  void nextPage(int index) async {
    await _setIsFirstRun();
    switch (index) {
      case 0:
        navigator.pushReplacementName(AppRouter.login);
        break;
      case 1:
        navigator.pushReplacementName(AppRouter.register);
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
      final udid = await DeviceUntil.getUDID();
      final user = await authRepository.signUp(
        AppUtils.generateDeviceEmail(udid),
        udid,
        udid,
      );
      if (user == null) {
        navigator.showSnackBar("Unable to connect to the server.", Colors.red);
        return;
      }
      navigator.showSnackBar("Login successful", Colors.green);
      await navigator.openHomePage();
    } catch (e) {
      log(e.toString());
    }
  }
}
