import 'package:flutter/cupertino.dart';
import 'package:todo_app/ui/pages/focus/focus_navigator.dart';

class FocusProvider extends ChangeNotifier {
  final FocusNavigator navigator;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  FocusProvider({required this.navigator});

  void changeFocus(){
    _isPlaying = !_isPlaying;
    notifyListeners();
  }
}