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

  TodoEntity getTodoById(int id){
    return _todos.firstWhere((todo) => todo.id == id);
  }

  void setTodos(List<TodoEntity> todos) {
    log(todos.length.toString());
    _todos = todos;
    _sortTodosByDuaDateDesc();
  }

  Future<bool> deleteTodo(int id) async {
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

  Future<TodoEntity?> addTodo(TodoEntity todo) async {
    try{
      await Future.delayed(Duration(seconds: 1));
      _todos.add(todo);
      _sortTodosByDuaDateDesc();
      return todo;
    } catch(e){
      log(e.toString());
      notifyListeners();
      return null;
    }
  }

  Future<TodoEntity?> changeTodo(TodoEntity todo) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      final index = _todos.indexWhere((element) => element.id == todo.id);
      final updatedTodo = TodoEntity(
        id: todo.id,
        title: todo.title,
        note: todo.note,
        duaDate: todo.duaDate,
        isComplete: todo.isComplete,
        createAt: todo.createAt,
        updateAt: todo.updateAt,
        category: todo.category,
      );

      _todos[index] = updatedTodo;
      _sortTodosByDuaDateDesc();
      return todo;
    } catch(e){
      log(e.toString());
      notifyListeners();
      return null;
    }
  }

  void _sortTodosByDuaDateDesc() {
    _todos.sort((a, b) => a.duaDate.compareTo(b.duaDate));
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
