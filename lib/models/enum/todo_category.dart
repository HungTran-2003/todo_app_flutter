enum TodoCategory {
  task,
  event,
  goal,
}

extension TodoCategoryExtension on TodoCategory {
  static TodoCategory fromString(String value) {
    return TodoCategory.values.firstWhere(
          (e) => e.typeName == value
    );
  }

  String get typeName {
    switch (this) {
      case TodoCategory.task:
        return "Task";
      case TodoCategory.event:
        return "Event";
      case TodoCategory.goal:
        return "Goal";
      }
  }
}