
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/database/app_share_preferences.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_navigator.dart';

class SplashProvider extends ChangeNotifier {

  SplashNavigator? _navigator;

  bool isLoading = false;
  bool isFirstRun = false;

  SplashProvider(SplashNavigator navigator){
    _navigator = navigator;
    init();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    isFirstRun = await AppSharePreferences.isFirstRun();
    log(isFirstRun.toString());
  }

  void nextPage() async {
    await Future.delayed(const Duration(seconds: 1));
    if (isFirstRun) {
      _navigator?.openOnBoardingPage();
    } else {
      _navigator?.openHomePage();
    }
  }

}