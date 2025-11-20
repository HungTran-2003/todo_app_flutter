import 'package:todo_app/models/enum/todo_category.dart';

class TodoEntity {
  int id;
  String title;
  String? note;
  DateTime duaDate;
  bool isComplete = false;
  DateTime createAt;
  DateTime updateAt;
  TodoCategory category = TodoCategory.task;

  TodoEntity({
    required this.id,
    required this.title,
    this.note,
    required this.duaDate,
    this.isComplete = false,
    required this.createAt,
    required this.updateAt,
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
      updateAt: DateTime.parse(json['update_at'] as String),
      category: TodoCategoryExtension.fromString(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'duaDate': duaDate.toIso8601String(),
      'isComplete': isComplete,
      'createAt': createAt.toIso8601String(),
      'updateAt': updateAt.toIso8601String(),
      'category': category.name,
    };
  }
}