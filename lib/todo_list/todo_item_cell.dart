import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/data_class/todo_item.dart';

class TodoItemCell extends StatelessWidget {

  final TodoItem todoItem;

  const TodoItemCell({
    Key? key,
    required this.todoItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(
            todoItem.isCompleted ? Icons.check_box : Icons.crop_square_rounded, 
            color: _trailingIconColor
          ),
        ),
        _priorityWidget,
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 16, 
                  bottom: todoItem.deadline != null ? 0 : 10
                ),
                child: Text(
                  todoItem.text, 
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: todoItem.isCompleted ? Colors.grey : Colors.black, 
                    fontSize: 17,
                    decoration: todoItem.isCompleted ? TextDecoration.lineThrough : TextDecoration.none
                  )
                ),
              ),
              _deadlineWidget
            ],
            crossAxisAlignment: CrossAxisAlignment.start
          )
        ),
        const Padding(
          padding: EdgeInsets.all(14),
          child: Icon(Icons.info_outline, color: Colors.grey),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget get _deadlineWidget {
    if (todoItem.deadline == null) {
      return const SizedBox.shrink();
    }
    
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 10),
      child: Text(
        DateFormat('dd.MM.yyyy').format(todoItem.deadline!),
        style: const TextStyle(color: Colors.grey, fontSize: 12)
      ),
    );
  }

  Widget get _priorityWidget {
    if (todoItem.priority == TodoItemPriority.normal) {
      return const SizedBox.shrink();
    }
    
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        todoItem.priority == TodoItemPriority.high ? '‼ ' : '↓ ',
        style: TextStyle(
          color: todoItem.priority == TodoItemPriority.high ? Colors.red : Colors.grey, 
          fontSize: 19
        )
      ),
    );
  }

  Color get _trailingIconColor {
    if (todoItem.isCompleted) {
      return Colors.green;
    } else if (todoItem.priority == TodoItemPriority.high) {
      return Colors.red;
    }

    return Colors.grey;
  }
}
