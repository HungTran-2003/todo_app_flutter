import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/database/app_share_preferences.dart';
import 'package:todo_app/models/enum/language.dart';

class TodoProvider extends ChangeNotifier {
  Language _currentLanguage = Language.english;

  Locale get locale => _currentLanguage.local;

  Future<void> getInitSettings() async {
    log('init');
    final language = await AppSharePreferences.getCurrentLanguage();
    if (language != null && language != _currentLanguage) {
      _currentLanguage = language;
      notifyListeners();
    }
  }

  Future<void> changeLocale() async {
    log("changeLanguage");
    if (_currentLanguage == Language.english) {
      _currentLanguage = Language.vietnamese;
      await AppSharePreferences.setCurrentLanguage(Language.vietnamese);
    } else {
      _currentLanguage = Language.english;
      await AppSharePreferences.setCurrentLanguage(Language.english);
    }
    notifyListeners();
  }
}
