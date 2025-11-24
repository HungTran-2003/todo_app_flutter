import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/database/app_share_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  void setIsFirstRun() async {
    try {
      await AppSharePreferences.setFirstRun(value: false);
    } catch (e) {
      log(e.toString());
    }
  }
}
