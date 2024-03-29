import 'package:todolist/data_class/todo_item.dart';

enum TodoEditorMode { creating, editing }

class TodoEditorState {
  final TodoEditorMode mode;
  final TodoItem todoItem;
  final TodoItem? savedTodoItem;

  const TodoEditorState({
    required this.mode,
    required this.todoItem,
    this.savedTodoItem
  });

  bool get canTodoItemBeSaved {
    var isStateAfterSaving = mode == TodoEditorMode.editing && todoItem.isEqualTo(savedTodoItem);

    return !_isInitialState && !isStateAfterSaving;
  }

  bool get canTodoItemBeRemoved {
    return !_isInitialState;
  }

  bool get _isInitialState {
    var empty = TodoItem.convenient();

    return mode == TodoEditorMode.creating && 
      savedTodoItem == null && 
      todoItem.text == empty.text &&
      todoItem.priority == empty.priority &&
      todoItem.deadline == empty.deadline;
  }
}
