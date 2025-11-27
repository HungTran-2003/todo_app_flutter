import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/ui/pages/home/home_navigator.dart';

class HomeProvider extends ChangeNotifier {
  final HomeNavigator navigator;
  List<TodoEntity> todos;
  final _todoService = TodoService();

  DateTime currentTime = DateTime.now();

  HomeProvider({required this.navigator, required this.todos});

  List<TodoEntity> get inCompleteTodos =>
      todos.where((todo) => todo.isComplete == false).toList();
  List<TodoEntity> get completedTodos =>
      todos.where((todo) => todo.isComplete == true).toList();

  void startMinuteTimer() {
    final now = DateTime.now();
    final nextMinute = DateTime(now.year, now.month, now.day + 1);
    final initialDelay = nextMinute.difference(now);

    Future.delayed(initialDelay, () {
      currentTime = DateTime.now();
      notifyListeners();
    });
  }

  Future<void> deleteTodo(int todoId, bool isShowDialog) async {
    if (isShowDialog) {
      navigator.showSimpleDialog(
        title: "Delete Todo",
        content: "You want to delete this Todo?",
        textCancel: "Cancel",
        onConfirm: () async {
          navigator.showLoadingOverlay();
          await _deleteTodo(todoId);
          navigator.hideLoadingOverlay();
        },
      );
    } else {
      navigator.showLoadingOverlay();
      await _deleteTodo(todoId);
      navigator.hideLoadingOverlay();
    }
  }

  Future<void> openPageDetail({TodoEntity? todo}) async{
   final result = await navigator.openDetailPage(todo: todo);
   if (result) {
     todos = await _todoService.getTodos();
     _sortTodosByDuaDateDesc();
   }
  }

  Future<void> completedTodo(int index) async {
    navigator.showLoadingOverlay();
    try {
      final todo = inCompleteTodos[index];
      todo.isComplete = true;
      final updatedTodo = await _todoService.updateTodo(todo);
      if (updatedTodo == null) {
        navigator.showSnackBar("Completed Task Error", Colors.red);
      } else {
        final index = todos.indexWhere((element) => element.id == updatedTodo.id);
        if (index != -1) {
          todos[index] = updatedTodo;
          navigator.showSnackBar("Completed Task Successful", Colors.green);
        }
      }
    } catch(e){
      log(e.toString());
      navigator.showSnackBar("Completed Task Error", Colors.red);
    }
    notifyListeners();
    navigator.hideLoadingOverlay();
  }

  Future<void> _deleteTodo(int id) async {
    try {
      final result = await _todoService.deleteTodo(id);
      if (!result) return;
      todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
      navigator.showSnackBar("Delete Task Successful", Colors.green);
    } catch (e) {
      log(e.toString());
      notifyListeners();
      navigator.showSnackBar("Delete Task Error", Colors.red);
    }
  }

  void _sortTodosByDuaDateDesc() {
    todos.sort((a, b) => a.duaDate.compareTo(b.duaDate));
    notifyListeners();
  }
}
