import 'package:flutter/material.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/ui/pages/home/widgets/todo_item.dart';

class TodoSections extends StatelessWidget {
  final List<TodoEntity> todos;
  final String? sectionTitle;
  final VoidCallback onPressed;
  final VoidCallback onPressedCB;

  const TodoSections({super.key, required this.todos, this.sectionTitle, required this.onPressed, required this.onPressedCB});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(sectionTitle != null)...[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              sectionTitle!,
              style: AppTextStyles.bMediumSemiBold,
            ),
          )
        ],
        ...List.generate(todos.length, (index){
          final isFirst = index == 0;
          final isLast = index == todos.length - 1;
          return TodoItem(checkboxPress: onPressedCB, first: isFirst, last: isLast, todo: todos[index], onPressed: onPressed,);
        }),
      ],
    );
  }
}
