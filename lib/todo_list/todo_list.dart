import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todolist/stream/saved_todo_stream.dart';
import 'package:todolist/todo_list/test_data.dart';
import 'package:todolist/todo_list/todo_item_cell.dart';
import 'package:todolist/todo_list/todo_list_events.dart';
import 'package:todolist/todo_list/todo_list_logic.dart';
import 'package:todolist/todo_list/todo_list_state.dart';

class TodoList extends StatefulWidget {

  final SavedTodoSubscriber? savedTodoSubscriber;

  const TodoList({
    Key? key,
    this.savedTodoSubscriber
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _TodoListState createState() => _TodoListState(savedTodoSubscriber);
}

class _TodoListState extends State<TodoList> {

  final SavedTodoSubscriber? savedTodoSubscriber;

  _TodoListState(this.savedTodoSubscriber);

  @override
  void initState() {
    context.read<TodoListLogic>().add(InitialTodoListDataFetched(testData));
    savedTodoSubscriber?.read().listen((todoItem) { 
      context.read<TodoListLogic>().add(SavedTodoItem(todoItem));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListLogic, TodoListState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TodoItemCell(todoItem: state.items[index]);
          },
          itemCount: state.items.length,
        );
      }
    );
  }
}
