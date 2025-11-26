import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/services/todo_service.dart';

class TodoProvider extends ChangeNotifier {
  final _todoService = TodoService();
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
      final result = await _todoService.deleteTodo(id);
      if (!result) return false;
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
      final newTodo = await _todoService.createTodo(todo);
      if (newTodo == null) return null;
      _todos.add(newTodo);
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
      final updatedTodo = await _todoService.updateTodo(todo);
      if (updatedTodo == null) return null;
      final index = _todos.indexWhere((element) => element.id == todo.id);
      final newTodo = TodoEntity(
        id: updatedTodo.id,
        title: updatedTodo.title,
        note: updatedTodo.note,
        duaDate: updatedTodo.duaDate,
        isComplete: updatedTodo.isComplete,
        createAt: updatedTodo.createAt,
        updateAt: updatedTodo.updateAt,
        category: updatedTodo.category,
      );
      _todos[index] = newTodo;
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
