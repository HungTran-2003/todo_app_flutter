import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/models/entites/todo_entity.dart';
import 'package:todo_app/models/enum/todo_category.dart';
import 'package:todo_app/utils/app_date_util.dart';

class TodoItem extends StatelessWidget {
  final TodoEntity todo = TodoEntity(id: 1, title: "heelllo", duaDate: DateTime.now(), createAt: DateTime.now(), updateAt: DateTime.now(), category: TodoCategory.event, isComplete: false);
  final bool first;
  final bool last;
  final VoidCallback? onPressed;
  final VoidCallback checkboxPress;
  TodoItem({super.key, this.onPressed, required this.checkboxPress, required this.first, required this.last});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 1.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(first ? 16 : 0),
          topRight: Radius.circular(first ? 16 : 0),
          bottomLeft: Radius.circular(last ? 16 : 0),
          bottomRight: Radius.circular(last ? 16 : 0),
        ),
        child: InkWell(
          onTap: onPressed,
          overlayColor: WidgetStatePropertyAll((Colors.black.withAlpha(20))),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(first ? 16 : 0),
            topRight: Radius.circular(first ? 16 : 0),
            bottomLeft: Radius.circular(last ? 16 : 0),
            bottomRight: Radius.circular(last ? 16 : 0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildItemTodo(),
          ),
        ),
      ),
    );
  }
  
  Widget _buildItemTodo(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
          opacity: todo.isComplete ? 0.5 : 1,
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColor(todo.category.typeName),
            ),
            child: Center(
              child: SvgPicture.asset(
                todo.assetsCategory,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12,),
        Opacity(
          opacity: todo.isComplete ? 0.5 : 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                todo.title,
                style: AppTextStyles.bMediumSemiBold.copyWith(
                  decoration: todo.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
              Text(
                AppDateUtil.toDateTodayString(todo.duaDate),
                style: AppTextStyles.bMediumMedium.copyWith(
                  // color: AppColors.textBlack.withAlpha(80),
                  decoration: todo.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ]
          ),
        ),
        const Spacer(),
        Checkbox(value: todo.isComplete, onChanged: (value){
          checkboxPress();
        })
      ],
    );
  }

  Color getColor(String value) {
    switch (value) {
      case "Task":
        return AppColors.iconTask;
      case "Event":
        return AppColors.iconEvent;
      case "Goal":
        return AppColors.iconGoal;
    }
    return Colors.red;
  }
}
