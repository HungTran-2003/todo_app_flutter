import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/ui/pages/home/home_provider.dart';
import 'package:todo_app/ui/pages/home/widgets/todo_item.dart';

class TodoSections extends StatelessWidget {
  final List<TodoEntity> todos;
  final String? sectionTitle;
  final ValueChanged<int> onPressed;
  final ValueChanged<int> clickCheckBox;
  final Function(bool, int) delete;

  const TodoSections({
    super.key,
    required this.todos,
    this.sectionTitle,
    required this.onPressed,
    required this.clickCheckBox,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sectionTitle != null && todos.isNotEmpty) ...[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            child: Text(sectionTitle!, style: AppTextStyles.bMediumSemiBold),
          ),
        ],
        ...List.generate(todos.length, (index) {
          final isFirst = index == 0;
          final isLast = index == todos.length - 1;
          return TodoItem(
            checkboxPress: () {
              clickCheckBox(index);
            },
            first: isFirst,
            last: isLast,
            todo: todos[index],
            onPressed: () {
              onPressed(index);
            },
            delete: (value){
              delete(value, index);
            },
          );
        }),
      ],
    );
  }
}
