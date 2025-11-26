import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/models/enum/todo_category.dart';
import 'package:todo_app/ui/pages/detail/detail_navigator.dart';
import 'package:todo_app/utils/app_date_util.dart';

class DetailProvider extends ChangeNotifier {
  final DetailNavigator navigator;
  final TodoProvider provider;

  TodoEntity? todo;

  int categoryIndex = 1;

  DetailProvider({required this.navigator, required this.provider});

  void changeCategory(int index) {
    categoryIndex = index;
    log("$categoryIndex ada");
    todo!.category = TodoCategory.values[index - 1];
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
      );
      todo = await provider.addTodo(todo!);
    } else {
      todo!.title = title;
      todo!.duaDate = duaDate;
      todo!.note = note;
      todo!.updateAt = DateTime.now();
      todo = await provider.changeTodo(todo!);
    }
    navigator.hideLoadingOverlay();
    navigator.pop();
  }

  Future<void> fetchInitialData(int? todoId) async {
    if (todoId != null) {
      try {
        todo = provider.getTodoById(todoId);
        if (todo != null) {
          categoryIndex = _getCategoryIndex(todo!.category);
        }
      } catch (e) {
        log(e.toString());
        navigator.showSimpleDialog(title: "Error", content: "Error");
      }
    }
  }

  int _getCategoryIndex(TodoCategory category) {
    switch (category) {
      case TodoCategory.goal:
        return 3;
      case TodoCategory.task:
        return 1;
      case TodoCategory.event:
        return 2;
    }
  }
}
