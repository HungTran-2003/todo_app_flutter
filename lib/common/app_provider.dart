import 'dart:async';

import 'package:flutter/cupertino.dart';

class TodoProvider extends ChangeNotifier {
  DateTime currentTime = DateTime.now();
  Timer? _timer;

  TodoProvider() {
    _startMinuteTimer();
  }

  void _startMinuteTimer() {
    final now = DateTime.now();
    final nextMinute = DateTime(
      now.year,
      now.month,
      now.day + 1,
    );

    final initialDelay = nextMinute.difference(now);

    Future.delayed(initialDelay, () {
      currentTime = DateTime.now();
      notifyListeners();
      _timer = Timer.periodic(Duration(days: 1), (_) {
        currentTime = DateTime.now();
        notifyListeners();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}