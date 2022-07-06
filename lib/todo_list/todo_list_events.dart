import 'package:todolist/data_class/todo_item.dart';

abstract class TodoListEvent {
  const TodoListEvent();
}

class InitialTodoListDataFetched implements TodoListEvent {

  final List<TodoItem> items;

  const InitialTodoListDataFetched(this.items);
}
