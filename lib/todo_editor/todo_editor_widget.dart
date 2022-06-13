import 'package:flutter/material.dart';
import 'package:todolist/todo_editor/todo_editor_layout.dart';

class TodoEditorWidget extends StatefulWidget {

  const TodoEditorWidget({Key? key}) : super(key: key);

  @override
  _TodoEditorWidgetState createState() => _TodoEditorWidgetState();
}

class _TodoEditorWidgetState extends State<TodoEditorWidget> {

  String? priority = "no";
  bool isDeadlineButtonVisible = false;
  DateTime deadlineDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    const highPriority = "!! high";
    
    return TodoEditorLayout(
      priority: priority, 
      priorities: const ["no", "low", highPriority], 
      highPriority: highPriority, 
      deadline: deadlineDate, 
      isDeadlineButtonVisible: isDeadlineButtonVisible, 
      onPriorityValueChanged: _onPriorityValueChanged,
      onDeadlineDatePressed: _selectDate,
      onDeadlineSwitchValueChanged: _onDeadlineSwitchValueChanged,
      onClose: _close,
    );
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }

  void _onPriorityValueChanged(String? newValue) {
    setState(() {
      priority = newValue;
    });
  }

  void _onDeadlineSwitchValueChanged(bool value) {
    setState(() {
      isDeadlineButtonVisible = value;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != deadlineDate) {
      setState(() {
        deadlineDate = picked;
      });
    }
  }
}
