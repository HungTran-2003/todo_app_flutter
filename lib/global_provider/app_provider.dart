import 'package:flutter/material.dart';
import 'package:todo_app/models/enum/language.dart';

class TodoProvider extends ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void changeLocale() {
    final code = _locale.languageCode;
    if(code == 'en'){
      _locale = const Locale('vi');
    }else{
      _locale = const Locale('en');
    }
    notifyListeners();
  }
}
