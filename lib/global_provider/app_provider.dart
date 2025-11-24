import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/entities/todo_entity.dart';

class TodoProvider extends ChangeNotifier {
  DateTime currentTime = DateTime.now();
  Timer? _timer;

  List<TodoEntity> _todos = [];

  List<TodoEntity> get todos =>
      _todos.where((todo) => todo.isComplete == false).toList();
  List<TodoEntity> get completedTodos =>
      _todos.where((todo) => todo.isComplete == true).toList();

  TodoProvider() {
    startMinuteTimer();
  }

  void startMinuteTimer() {
    final now = DateTime.now();
    final nextMinute = DateTime(now.year, now.month, now.day + 1);

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

  void setTodos(List<TodoEntity> todos) {
    log(todos.length.toString());
    _todos = todos;
  }

  Future<bool> deleteTodo(int id) async {
    notifyListeners();
    try {
      await Future.delayed(Duration(seconds: 2));
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString());
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
