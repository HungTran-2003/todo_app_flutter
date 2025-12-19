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
    TodoEntity? todo,
    required this.todoRepository,
    required this.notificationRepository,
  }) : _todo = todo;

  TodoEntity? _todo;
  TodoEntity? get todo => _todo;
  int _categoryIndex = 1;
  int get categoryIndex => _categoryIndex;

  void changeCategory(int index) {
    _categoryIndex = index;
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

    if (_todo == null) {
      _todo = TodoEntity(
        title: title,
        duaDate: duaDate,
        createAt: DateTime.now(),
        category: TodoCategory.values[categoryIndex - 1],
      );
      _todo = await _addTodo(_todo!);
    } else {
      _todo!.title = title;
      _todo!.duaDate = duaDate;
      _todo!.note = note;
      _todo!.updateAt = DateTime.now();
      _todo!.category = TodoCategory.values[categoryIndex - 1];
      _todo = await _changeTodo(_todo!);
    }
    navigator.hideLoadingOverlay();
    if (_todo == null) {
      navigator.pop(extra: false);
    } else {
      navigator.pop(extra: true);
    }
  }

  void setCategoryInit() {
    _categoryIndex = TodoCategory.values.indexOf(_todo!.category) + 1;
  }

  Future<TodoEntity?> _addTodo(TodoEntity todo) async {
    try {
      final newTodo = await todoRepository.createTodo(todo);
      if (newTodo == null) return null;
      await notificationRepository.scheduleNotification(
        id: newTodo.id!,
        title: newTodo.title,
        body: S.current.notification_body,
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
        body: S.current.notification_body,
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
