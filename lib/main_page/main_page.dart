import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/stream/saved_todo_stream.dart';
import 'package:todolist/todo_editor/todo_editor.dart';
import 'package:todolist/todo_editor/todo_editor_logic.dart';
import 'package:todolist/todo_list/todo_list.dart';
import 'package:todolist/todo_list/todo_list_logic.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My tasks'),
      ),
      body: BlocProvider(
        create: (_) => TodoListLogic(),
        child: TodoList(savedTodoSubscriber: SavedTodoStream()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPlusButtonPressed(context),
        tooltip: 'Create new Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onPlusButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => 
        BlocProvider(
          create: (_) => TodoEditorLogic(savedTodoPublisher: SavedTodoStream()),
          child: const TodoEditor(),
        )
      ),
    );
  }
}
