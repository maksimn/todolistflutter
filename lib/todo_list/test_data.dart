import 'package:todolist/data_class/todo_item.dart';

var testData = [
  TodoItem.convenient(text: 'To do something...', priority: TodoItemPriority.low, isCompleted: true),
  TodoItem.convenient(
    text: 'To do something else To do something else To do something else To do something else To do something else To do something else',
    deadline: DateTime.now(),
    priority: TodoItemPriority.high
  ),
  TodoItem.convenient(
    text: 'To do something...',
    deadline: DateTime.now()
  ),
  TodoItem.convenient(
    text: 'To do something else... To do something else... To do something else... ',
    isCompleted: true
  )
];
