import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/repositories/notification_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/pages/home/home_navigator.dart';

class HomeProvider extends ChangeNotifier {
  final HomeNavigator navigator;
  List<TodoEntity> todos;
  final TodoRepository todoRepository;
  final NotificationRepository notificationRepository;

  HomeProvider({
    required this.navigator,
    required this.todos,
    required this.todoRepository,
    required this.notificationRepository,
  });

  DateTime currentTime = DateTime.now();

  List<TodoEntity> get inCompleteTodos => todos
      .where(
        (todo) =>
            todo.isComplete == false && todo.duaDate.isAfter(DateTime.now()),
      )
      .toList();
  List<TodoEntity> get completedTodos =>
      todos.where((todo) => todo.isComplete == true).toList();
  List<TodoEntity> get overdueTodos => todos
      .where(
        (todo) =>
            todo.isComplete == false && todo.duaDate.isBefore(DateTime.now()),
      )
      .toList();

  void startMinuteTimer() {
    Future.doWhile(() async {
      final now = DateTime.now();
      final next = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute + 1,
      );

      await Future.delayed(next.difference(now));
      notifyListeners();
      return true;
    });
  }

  Future<void> deleteTodo(int todoId, bool isShowDialog) async {
    if (isShowDialog) {
      navigator.showSimpleDialog(
        title: S.current.dialog_title_delete,
        content: S.current.dialog_description_delete,
        textCancel: S.current.dialog_cancel,
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

  Future<void> openPageDetail({int? todoId}) async {
    final todo = todos.where((todo) => todo.id == todoId).singleOrNull;
    final result = await navigator.openDetailPage(todo: todo);
    if (result) {
      todos = await todoRepository.getTodos();
      _sortTodosByDuaDateDesc();
    }
  }

  Future<void> completedTodo(int todoId) async {
    navigator.showLoadingOverlay();
    try {

      final todo = inCompleteTodos.where((todo) => todo.id == todoId).single;
      todo.isComplete = true;
      final updatedTodo = await todoRepository.updateTodo(todo);
      if (updatedTodo == null) {
        navigator.showSnackBar(
          S.current.error_message_complete_task,
          Colors.red,
        );
      } else {
        final index = todos.indexWhere(
          (element) => element.id == updatedTodo.id,
        );
        if (index != -1) {
          todos[index] = updatedTodo;
          await notificationRepository.cancelNotification(updatedTodo.id!);
          navigator.showSnackBar(
            S.current.home_message_complete_task,
            Colors.green,
          );
        }
      }
    } catch (e) {
      log(e.toString());
      navigator.showSnackBar(S.current.error_message_complete_task, Colors.red);
    }
    notifyListeners();
    navigator.hideLoadingOverlay();
  }

  Future<void> _deleteTodo(int id) async {
    try {
      final result = await todoRepository.deleteTodo(id);
      if (!result) return;
      todos.removeWhere((todo) => todo.id == id);
      await notificationRepository.cancelNotification(id);
      notifyListeners();
      navigator.showSnackBar(S.current.home_message_delete_task, Colors.green);
    } catch (e) {
      log(e.toString());
      notifyListeners();
      navigator.showSnackBar(S.current.error_message_delete_task, Colors.red);
    }
  }

  void _sortTodosByDuaDateDesc() {
    todos.sort((a, b) => a.duaDate.compareTo(b.duaDate));
    notifyListeners();
  }
}
