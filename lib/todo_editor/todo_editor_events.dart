import 'package:todolist/data_class/todo_item.dart';

abstract class TodoEditorEvent {
  const TodoEditorEvent();
}

class TextChangedInTodoEditor implements TodoEditorEvent {

  final String text;

  const TextChangedInTodoEditor(this.text);
}

class PriorityChangedInTodoEditor implements TodoEditorEvent {

  final TodoItemPriority priority;

  const PriorityChangedInTodoEditor(this.priority); 
}

class DeadlineChangedInTodoEditor implements TodoEditorEvent {

  final DateTime? deadline;

  const DeadlineChangedInTodoEditor(this.deadline);
}

class TodoItemSavedInTodoEditor implements TodoEditorEvent { }

class TodoItemDeletedInTodoEditor implements TodoEditorEvent { }
