import 'dart:async';
import 'package:todolist/data_class/todo_item.dart';

abstract class SavedTodoPublisher {

  void send(TodoItem todoItem);
} 

abstract class SavedTodoSubscriber {

  Stream<TodoItem> read();
} 

class SavedTodoStream implements SavedTodoPublisher, SavedTodoSubscriber {

  final _controller = StreamController<TodoItem>();

  static final SavedTodoStream _singleton = SavedTodoStream._internal();

  factory SavedTodoStream() {
    return _singleton;
  }

  SavedTodoStream._internal();

  @override
  void send(TodoItem todoItem) {
    _controller.add(todoItem);
  }

  @override
  Stream<TodoItem> read() {
    return _controller.stream;
  }
}
