import 'package:todo_app/models/enum/todo_category.dart';

class TodoEntity {
  int? id;
  String title;
  String? note;
  DateTime duaDate;
  bool isComplete = false;
  DateTime createAt;
  DateTime? updateAt;
  TodoCategory category = TodoCategory.task;

  TodoEntity({
    this.id,
    required this.title,
    this.note,
    required this.duaDate,
    this.isComplete = false,
    required this.createAt,
    this.updateAt,
    this.category = TodoCategory.task,
  });

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      note: json['note'] as String?,
      duaDate: DateTime.parse(json['dua_date'] as String),
      isComplete: json['is_complete'] as bool? ?? false,
      createAt: DateTime.parse(json['create_at'] as String),
      updateAt: json['update_at'] != null
          ? DateTime.parse(json['update_at'])
          : null,
      category: TodoCategoryExtension.fromString(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'note': note,
      'dua_date': duaDate.toIso8601String(),
      'is_complete': isComplete,
      'create_at': createAt.toIso8601String(),
      'update_at': updateAt?.toIso8601String(),
      'category': category.name,
    };
  }

  String get assetsCategory {
    return "assets/vectors/${category.name}.svg";
  }
}
