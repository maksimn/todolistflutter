import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data_class/todo_item.dart';
import 'package:todolist/todo_editor/components/todo_editor_app_bar.dart';
import 'package:todolist/todo_editor/components/todo_editor_deadline_selector.dart';
import 'package:todolist/todo_editor/components/todo_editor_delete_button.dart';
import 'package:todolist/todo_editor/components/todo_editor_priority_selector.dart';
import 'package:todolist/todo_editor/components/todo_editor_text_input.dart';
import 'package:todolist/todo_editor/todo_editor_logic.dart';
import 'package:todolist/todo_editor/todo_editor_state.dart';
import 'package:todolist/todo_editor/todo_editor_events.dart';

const _priorityTitle = 'Priority';

class TodoEditor extends StatelessWidget {
  const TodoEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEditorLogic, TodoEditorState>(
      builder: (context, state) {
        return Scaffold(
          appBar: TodoEditorAppBar(
            onCloseButtonPressed: () => _onCloseButtonPressed(context),
            onSaveButtonPressed: state.canTodoItemBeSaved ? () => _onSaveButtonPressed(context) : null,
            saveButtonTitleColor: state.canTodoItemBeSaved ? Colors.blue : Colors.grey,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                TodoEditorTextInput(
                  text: state.todoItem.text,
                  onTextChanged: (text) => _onTextChanged(text, context),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 26, top: 8),
                    child: Text(_priorityTitle, style: TextStyle(color: Colors.black, fontSize: 17.0)),
                  ),
                ),
                TodoEditorPrioritySelector(
                  priority: state.todoItem.priority, 
                  onPriorityChanged: (priority) => _onPriorityValueChanged(priority, context)
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
                  child: Divider(color: Colors.grey)
                ),
                TodoEditorDeadlineSelector(
                  deadline: state.todoItem.deadline ?? DateTime.now(),
                  isDeadlineVisible: state.todoItem.deadline != null,
                  onDeadlineButtonPressed: () => _selectDate(state, context),
                  onDeadlineSwitchValueChanged: (value) => _onDeadlineSwitchValueChanged(value, context),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Divider(color: Colors.grey),
                ),
                TodoEditorDeleteButton(
                  canTodoItemBeRemoved: state.canTodoItemBeRemoved,
                  onButtonPressed: () => _onDeleteButtonPressed(context)
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void _onSaveButtonPressed(BuildContext context) {
    context.read<TodoEditorLogic>().add(TodoItemSavedInTodoEditor());
  }

  void _onCloseButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onDeleteButtonPressed(BuildContext context) {
    context.read<TodoEditorLogic>().add(TodoItemDeletedInTodoEditor());
  }

  void _onTextChanged(String text, BuildContext context) {
    context.read<TodoEditorLogic>().add(TextChangedInTodoEditor(text));
  }

  void _onPriorityValueChanged(TodoItemPriority priority, BuildContext context) {
    context.read<TodoEditorLogic>().add(PriorityChangedInTodoEditor(priority));
  }

  Future<void> _selectDate(TodoEditorState state, BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime(2015, 8), 
        lastDate: DateTime(2101)
    );

    if (picked != null && picked != state.todoItem.deadline) {
      context.read<TodoEditorLogic>().add(DeadlineChangedInTodoEditor(picked));
    }
  }

  void _onDeadlineSwitchValueChanged(bool value, BuildContext context) {
      context.read<TodoEditorLogic>().add(DeadlineChangedInTodoEditor(value ? DateTime.now() : null));    
  }
}
