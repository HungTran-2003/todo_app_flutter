import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/models/enum/todo_category.dart';
import 'package:todo_app/repositories/notification_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/pages/detail/detail_navigator.dart';
import 'package:todo_app/utils/app_date_util.dart';

class DetailProvider extends ChangeNotifier {
  final DetailNavigator navigator;
  final TodoRepository todoRepository;
  final NotificationRepository notificationRepository;

  DetailProvider({
    required this.navigator,
    this.todo,
    required this.todoRepository,
    required this.notificationRepository,
  });

  TodoEntity? todo;
  int categoryIndex = 1;

  void changeCategory(int index) {
    categoryIndex = index;
    log("$categoryIndex ada");
    notifyListeners();
  }

  Future<void> saveTodo(
    String title,
    String dateText,
    String timeText,
    String note,
  ) async {
    navigator.showLoadingOverlay();
    final date = AppDateUtil.fromDateString(dateText);
    final time = AppDateUtil.formTimeString(timeText);
    final duaDate = DateTime(
      date!.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (todo == null) {
      todo = TodoEntity(
        title: title,
        duaDate: duaDate,
        createAt: DateTime.now(),
        category: TodoCategory.values[categoryIndex - 1],
      );
      todo = await _addTodo(todo!);
    } else {
      todo!.title = title;
      todo!.duaDate = duaDate;
      todo!.note = note;
      todo!.updateAt = DateTime.now();
      todo!.category = TodoCategory.values[categoryIndex - 1];
      todo = await _changeTodo(todo!);
    }
    navigator.hideLoadingOverlay();
    if (todo == null) {
      navigator.pop(extra: false);
    } else {
      navigator.pop(extra: true);
    }
  }

  void setCategoryInit() {
    categoryIndex = TodoCategory.values.indexOf(todo!.category) + 1;
  }

  Future<TodoEntity?> _addTodo(TodoEntity todo) async {
    try {
      final newTodo = await todoRepository.createTodo(todo);
      if (newTodo == null) return null;
      await notificationRepository.scheduleNotification(
        id: newTodo.id!,
        title: newTodo.title,
        body: "test",
        scheduledDate: newTodo.duaDate,
      );
      navigator.showSnackBar(
        S.current.detail_message_add_task_successful,
        Colors.green,
      );
      return todo;
    } catch (e) {
      log(e.toString());
      navigator.showSnackBar(
        S.current.detail_message_add_task_error,
        Colors.red,
      );
      return null;
    }
  }

  Future<TodoEntity?> _changeTodo(TodoEntity todo) async {
    try {
      final updatedTodo = await todoRepository.updateTodo(todo);
      if (updatedTodo == null) return null;
      navigator.showSnackBar(
        S.current.detail_message_change_task_successful,
        Colors.green,
      );
      await notificationRepository.cancelNotification(todo.id!);
      await notificationRepository.scheduleNotification(
        id: updatedTodo.id!,
        title: updatedTodo.title,
        body: "test",
        scheduledDate: updatedTodo.duaDate,
      );
      return todo;
    } catch (e) {
      log(e.toString());
      navigator.showSnackBar(
        S.current.detail_message_change_task_error,
        Colors.red,
      );
      return null;
    }
  }
}
