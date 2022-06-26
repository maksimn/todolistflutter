import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data_class/todo_item.dart';
import 'package:todolist/todo_editor/todo_editor.dart';
import 'package:todolist/todo_editor/todo_editor_logic.dart';
import 'package:todolist/todo_editor/todo_editor_state.dart';

class MainTodoListWidget extends StatefulWidget {
  const MainTodoListWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainTodoListWidget> createState() => _MainTodoListWidgetState();
}

class _MainTodoListWidgetState extends State<MainTodoListWidget> {

  void _onPlusButtonPressed() {
    var initialState = TodoEditorState(
      mode: TodoEditorMode.editing, 
      todoItem: TodoItem.convenient(
        text: "Some txt.", 
        priority: TodoItemPriority.low, 
        deadline: DateTime.now()
      )
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => 
        BlocProvider(
          create: (_) => TodoEditorLogic(initialState),
          child: const TodoEditor(),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPlusButtonPressed,
        tooltip: 'Create new Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
