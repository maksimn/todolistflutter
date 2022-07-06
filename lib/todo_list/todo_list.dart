import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todolist/data_class/todo_item.dart';
import 'package:todolist/todo_list/todo_list_events.dart';
import 'package:todolist/todo_list/todo_list_logic.dart';
import 'package:todolist/todo_list/todo_list_state.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  void initState() {
    context.read<TodoListLogic>().add(InitialTodoListDataFetched([
      TodoItem.convenient(text: 'To do something...'),
      TodoItem.convenient(text: 'To do something else...')
    ]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListLogic, TodoListState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(state.items[index].text),
              subtitle: const Text(''),
              leading: const Icon(Icons.radio_button_on),
              onTap: () => {}
            );
          },
          itemCount: state.items.length,
        );
      }
    );
  }
}
