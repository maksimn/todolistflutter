import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todolist/data_class/todo_item.dart';
import 'package:todolist/todo_editor/todo_editor_logic.dart';
import 'package:todolist/todo_editor/todo_editor_state.dart';
import 'package:todolist/todo_editor/todo_editor_events.dart';

const _saveButtonTitle = 'SAVE    ';
const _textHint = 'Enter a text...';
const _priorityTitle = 'Priority';
const _deadlineTitle = 'Deadline';
const _deleteButtonTitle = ' DELETE';

const _normalPriority = 'no';
const _lowPriority = 'low';
const _highPriority = "!! high";
const _priorities = [_normalPriority, _lowPriority, _highPriority];

final _textEditingController = TextEditingController();

class TodoEditor extends StatelessWidget {
  const TodoEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var priorityDropdownMenuItems = _priorities.map((string) => DropdownMenuItem<String>(
      value: string, 
      child: Text(
        string, 
        style: TextStyle(color: string == _highPriority ? Colors.red : Colors.black)
      )
    )).toList();

    return BlocBuilder<TodoEditorLogic, TodoEditorState>(
      builder: (context, state) {
        _textEditingController.text = state.todoItem.text;
        _textEditingController.selection = TextSelection.fromPosition(TextPosition(
          offset: _textEditingController.text.length
        ));

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xfff2f2f2),
            elevation: 0.5,
            iconTheme: const IconThemeData(color: Colors.black),
            leading: IconButton(
              onPressed: () => _onCloseButtonPressed(context),
              icon: const Icon(Icons.close),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: state.canTodoItemBeSaved ? () => _onSaveButtonPressed(context) : null,
                child: Text(
                  _saveButtonTitle, 
                  style: TextStyle(
                    color: state.canTodoItemBeSaved ? Colors.blue : Colors.grey, 
                    fontSize: 17.0
                  )
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 26.0),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: _textHint,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      keyboardType: TextInputType.multiline,
                      minLines: 8,
                      maxLines: 8,
                      onChanged: (text) => _onTextChanged(text, context),
                    )),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 26, top: 8),
                    child: Text(_priorityTitle, style: TextStyle(color: Colors.black, fontSize: 17.0)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 26),
                    child: DropdownButton<String>(
                      items: priorityDropdownMenuItems,
                      value: _convert(state.todoItem.priority),
                      onChanged: (value) => _onPriorityValueChanged(value, context),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 86,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 26, top: (_isDeadlineVisible(state) ? 18 : 30)),
                      child: Column(
                        children: [
                          const Text(
                            _deadlineTitle, 
                            style: TextStyle(color: Colors.black, fontSize: 17.0)
                          ),
                          Visibility(
                            child: TextButton(
                              onPressed: () => _selectDate(state, context),
                              child: Text(
                                DateFormat('dd.MM.yyyy').format(state.todoItem.deadline ?? DateTime.now()), 
                                style: const TextStyle(color: Colors.blue, fontSize: 14)
                              ),
                            ),
                            visible: _isDeadlineVisible(state),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 26, top: 0),
                      child: Switch(
                        value: _isDeadlineVisible(state),
                        onChanged: (value) => _onDeadlineSwitchValueChanged(value, context),
                      ),
                    ),
                  ]),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14, top: 24),
                    child: TextButton(
                      onPressed: state.canTodoItemBeRemoved ? () => _onDeleteButtonPressed(context) : null,
                      child: RichText(
                        text: TextSpan(
                        children: [
                          WidgetSpan(child: Icon(
                            Icons.delete, 
                            size: 18, 
                            color: state.canTodoItemBeRemoved ? Colors.red : Colors.grey)
                          ),
                          TextSpan(
                            text: _deleteButtonTitle, 
                            style: TextStyle(
                              color: state.canTodoItemBeRemoved ? Colors.red : Colors.grey, 
                              fontSize: 17.0
                            )
                          ),
                        ],
                        ),
                      ),
                    ),
                  ),
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

  void _onPriorityValueChanged(String? value, BuildContext context) {
    var priority = _convertToTodoItemPriority(value);
    
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

  bool _isDeadlineVisible(TodoEditorState state) {
    return state.todoItem.deadline != null;
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
