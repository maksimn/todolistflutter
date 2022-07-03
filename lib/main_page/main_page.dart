import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data_class/todo_item.dart';
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
        child: const TodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPlusButtonPressed(context),
        tooltip: 'Create new Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onPlusButtonPressed(BuildContext context) {
    var todoItem = TodoItem.convenient(
      text: "Some txt.", 
      priority: TodoItemPriority.low, 
      deadline: DateTime.now()
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => 
        BlocProvider(
          create: (_) => TodoEditorLogic(todoItem),
          child: const TodoEditor(),
        )
      ),
    );
  }
}
