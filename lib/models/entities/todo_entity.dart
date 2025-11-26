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
      updateAt: json['update_at'] != null ? DateTime.parse(json['update_at']) : null,
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

  static List<TodoEntity> get mockData {
    return [
      TodoEntity(
        id: 1,
        title: "heelllo",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.event,
        isComplete: false,
      ),
      TodoEntity(
        id: 2,
        title: "2",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.task,
        isComplete: false,
      ),
      TodoEntity(
        id: 3,
        title: "3",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.event,
        isComplete: false,
      ),
      TodoEntity(
        id: 4,
        title: "4",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.task,
        isComplete: false,
      ),
      TodoEntity(
        id: 5,
        title: "5",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.goal,
        isComplete: false,
      ),
      TodoEntity(
        id: 6,
        title: "6",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.event,
        isComplete: false,
      ),
      TodoEntity(
        id: 7,
        title: "7",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.goal,
        isComplete: false,
      ),
      TodoEntity(
        id: 8,
        title: "heelllo",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.goal,
        isComplete: true,
      ),
      TodoEntity(
        id: 9,
        title: "2",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.task,
        isComplete: true,
      ),
      TodoEntity(
        id: 10,
        title: "3",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.goal,
        isComplete: true,
      ),
      TodoEntity(
        id: 11,
        title: "4",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.task,
        isComplete: true,
      ),
      TodoEntity(
        id: 12,
        title: "5",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.event,
        isComplete: true,
      ),
      TodoEntity(
        id: 13,
        title: "6",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.event,
        isComplete: true,
      ),
      TodoEntity(
        id: 14,
        title: "7",
        duaDate: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        category: TodoCategory.goal,
        isComplete: true,
      ),
    ];
  }
}
