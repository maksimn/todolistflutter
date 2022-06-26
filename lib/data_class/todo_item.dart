import 'package:uuid/uuid.dart';

enum TodoItemPriority { low, normal, high }

class TodoItem {
  String id;
  String text;
  TodoItemPriority priority;
  DateTime? deadline;
  bool isCompleted;
  int createdAt;
  int updatedAt;
  bool isDirty;

  TodoItem({required this.id, 
            required this.text, 
            required this.priority, 
            required this.deadline, 
            required this.isCompleted, 
            required this.createdAt, 
            required this.updatedAt, 
            required this.isDirty});

  TodoItem.convenient({
    String? id,
    String? text,
    TodoItemPriority? priority,
    DateTime? deadline,
    bool? isCompleted,
    int? createdAt,
    int? updatedAt,
    bool? isDirty
  }) : this(
    id: id ?? const Uuid().v4(),
    text: text ?? '',
    priority: priority ?? TodoItemPriority.normal,
    deadline: deadline,
    isCompleted: isCompleted ?? false,
    createdAt: createdAt ?? 0,
    updatedAt: updatedAt ?? 0,
    isDirty: isDirty ?? false
  );

  TodoItem copyWith({
    String? text,
    TodoItemPriority? priority,
    bool? isCompleted,
    int? createdAt,
    int? updatedAt,
    bool? isDirty
  }) {
    return TodoItem(
      id: id,
      text: text ?? this.text,
      priority: priority ?? this.priority,
      deadline: deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDirty: isDirty ?? this.isDirty
    );
  }

  TodoItem copyWithOptional({
    DateTime? deadline
  }) {
    return TodoItem(
      id: id,
      text: text,
      priority: priority,
      deadline: deadline,
      isCompleted: isCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDirty: isDirty
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'priority': priority,
    'deadline': deadline
  };
}
