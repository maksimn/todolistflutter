import 'package:todolist/data_class/todo_item.dart';

class TodoListState {
  final List<TodoItem> items;

  const TodoListState({
    required this.items,
  });
}
