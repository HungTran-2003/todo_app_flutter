import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/models/enum/todo_category.dart';
import 'package:todo_app/utils/app_date_util.dart';

class TodoItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(first ? 16 : 0),
      topRight: Radius.circular(first ? 16 : 0),
      bottomLeft: Radius.circular(last ? 16 : 0),
      bottomRight: Radius.circular(last ? 16 : 0),
    );

    return Slidable(
      key: ValueKey(todo.id),
      closeOnScroll: false,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.3,
        dismissible: DismissiblePane(
          onDismissed: () {
            delete(false);
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
              delete(true);
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
          borderRadius: borderRadius,
          child: InkWell(
            onTap: onPressed,
            overlayColor: const WidgetStatePropertyAll((Colors.black12)),
            borderRadius: borderRadius,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildItemTodo(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemTodo(BuildContext context) {
    final bool isOverdue =
        !todo.isComplete && todo.duaDate.isBefore(DateTime.now());

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
              color: _getColor(todo.category),
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
        const SizedBox(width: 12),
        Expanded(
          child: Opacity(
            opacity: todo.isComplete ? 0.5 : 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: AppTextStyles.bMediumSemiBold.copyWith(
                    decoration: todo.isComplete
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: isOverdue ? Colors.red : null,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  AppDateUtil.toDateTodayString(todo.duaDate),
                  style: AppTextStyles.bSmallMedium.copyWith(
                    color: isOverdue
                        ? Colors.red.withValues(alpha: 0.7)
                        : AppColors.textBlack.withValues(alpha: 0.7),
                    decoration: todo.isComplete
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        Checkbox(
          value: todo.isComplete,
          onChanged: (value) {
            checkboxPress();
          },
        ),
      ],
    );
  }

  // Đề xuất 3: Cải thiện hàm getColor
  Color _getColor(TodoCategory category) {
    switch (category) {
      case TodoCategory.task:
        return AppColors.iconTask;
      case TodoCategory.event:
        return AppColors.iconEvent;
      case TodoCategory.goal:
        return AppColors.iconGoal;
      // Không cần default vì enum đã bao phủ hết các trường hợp
    }
  }
}
