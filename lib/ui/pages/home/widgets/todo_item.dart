import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/models/enum/todo_category.dart';
import 'package:todo_app/utils/app_date_util.dart';

class TodoItem extends StatefulWidget {
  final TodoEntity todo;
  final bool first;
  final bool last;
  final VoidCallback? onPressed;
  final VoidCallback checkboxPress;
  final ValueChanged<bool> delete;
  const TodoItem({
    super.key,
    this.onPressed,
    required this.checkboxPress,
    required this.first,
    required this.last,
    required this.todo,
    required this.delete,
  });

  @override
  State<StatefulWidget> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.todo.id),
      closeOnScroll: false,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.3,
        dismissible: DismissiblePane(
          onDismissed: () {
            widget.delete(false);
          },
          confirmDismiss: () async {
            return await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(S.current.dialog_title_confirm),
                      content: Text(S.current.dialog_description_delete),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(S.current.dialog_cancel),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(S.current.dialog_confirm),
                        ),
                      ],
                    );
                  },
                ) ??
                false;
          },
          closeOnCancel: true,
        ),
        children: [
          SlidableAction(
            onPressed: (context) async {
              widget.delete(true);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: S.current.dialog_title_delete,
          ),
        ],
      ),
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 1.0),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.first ? 16 : 0),
            topRight: Radius.circular(widget.first ? 16 : 0),
            bottomLeft: Radius.circular(widget.last ? 16 : 0),
            bottomRight: Radius.circular(widget.last ? 16 : 0),
          ),
          child: InkWell(
            onTap: widget.onPressed,
            overlayColor: WidgetStatePropertyAll((Colors.black.withAlpha(20))),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.first ? 16 : 0),
              topRight: Radius.circular(widget.first ? 16 : 0),
              bottomLeft: Radius.circular(widget.last ? 16 : 0),
              bottomRight: Radius.circular(widget.last ? 16 : 0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildItemTodo(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemTodo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
          opacity: widget.todo.isComplete ? 0.5 : 1,
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColor(widget.todo.category.typeName),
            ),
            child: Center(
              child: SvgPicture.asset(
                widget.todo.assetsCategory,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Opacity(
          opacity: widget.todo.isComplete ? 0.5 : 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                widget.todo.title,
                style: AppTextStyles.bMediumSemiBold.copyWith(
                  decoration: widget.todo.isComplete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color:
                      !widget.todo.isComplete &&
                          widget.todo.duaDate.isBefore(DateTime.now())
                      ? Colors.red
                      : null,
                ),
              ),
              Text(
                AppDateUtil.toDateTodayString(widget.todo.duaDate),
                style: AppTextStyles.bSmallMedium.copyWith(
                  color:
                      !widget.todo.isComplete &&
                          widget.todo.duaDate.isBefore(DateTime.now())
                      ? Colors.red.withValues(alpha: 0.7)
                      : AppColors.textBlack.withValues(alpha: 0.7),
                  decoration: widget.todo.isComplete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Checkbox(
          value: widget.todo.isComplete,
          onChanged: (value) {
            widget.checkboxPress();
          },
        ),
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
