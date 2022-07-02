import 'package:flutter/material.dart';
import 'package:todolist/data_class/todo_item.dart';

const _normalPriority = 'no';
const _lowPriority = 'low';
const _highPriority = "!! high";
const _priorities = [_normalPriority, _lowPriority, _highPriority];
var _priorityDropdownButtonItems = _priorities
  .map((string) => DropdownMenuItem<String>(
    value: string,
    child: Text(
      string,
      style: TextStyle(color: string == _highPriority ? Colors.red : Colors.black)
    )
  )
).toList();

class TodoEditorPrioritySelector extends StatelessWidget {

  final TodoItemPriority priority;
  final void Function(TodoItemPriority) onPriorityChanged;

  const TodoEditorPrioritySelector({
    Key? key,
    required this.priority,
    required this.onPriorityChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 26),
        child: DropdownButton<String>(
          items: _priorityDropdownButtonItems,
          value: _convert(priority),
          onChanged: (value) => onPriorityChanged(_convertToTodoItemPriority(value)),
        ),
      ),
    );
  }

  String _convert(TodoItemPriority priority) {
    switch (priority) {
      case TodoItemPriority.low:
        return _lowPriority;
      case TodoItemPriority.normal:
        return _normalPriority;
      case TodoItemPriority.high:
        return _highPriority;
      default:
        return '';
    }
  }

  TodoItemPriority _convertToTodoItemPriority(String? value) {
    switch (value) {
      case _lowPriority:
        return TodoItemPriority.low;
      case _highPriority:
        return TodoItemPriority.high;
      default:
        return TodoItemPriority.normal;
    }
  }
}
