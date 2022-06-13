import 'package:flutter/material.dart';
import 'todo_editor_widget.dart';

class TodoEditorFactory {

  Widget create() => Container();
}

class TodoEditorFactoryImp implements TodoEditorFactory {

  @override
  Widget create() {
     return const TodoEditorWidget();
  }
}
