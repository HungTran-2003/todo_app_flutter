import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/entities/todo_entity.dart';

class TodoProvider extends ChangeNotifier {
  DateTime currentTime = DateTime.now();
  bool isLoading = true;
  Timer? _timer;

  List<TodoEntity> _todos = [];

  List<TodoEntity> get todos => _todos.where((todo) => todo.isComplete == false).toList();
  List<TodoEntity> get completedTodos => _todos.where((todo) => todo.isComplete == true).toList();

  TodoProvider() {
    _startMinuteTimer();
    _loadData();
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

  Future<void> _loadData() async {
    try{
      await Future.delayed(Duration(seconds: 2));
      _todos = TodoEntity.mockData;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> deleteTodo(int id) async {
    isLoading = true;
    notifyListeners();
    try{
      await Future.delayed(Duration(seconds: 2));
      _todos.removeWhere((todo) => todo.id == id);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString());
      isLoading = false;
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