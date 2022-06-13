import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

const String _saveButtonTitle = 'SAVE    ';
const String _textHint = 'Enter a text...';
const String _priorityTitle = 'Priority';
const String _deadlineTitle = 'Deadline';
const String _deleteButtonTitle = ' DELETE';

class TodoEditorLayout extends StatelessWidget {

  final String? priority;

  final List<String> priorities;

  final String highPriority;

  final DateTime deadline;

  final bool isDeadlineButtonVisible;

  final void Function(String?) onPriorityValueChanged;

  final void Function(BuildContext) onDeadlineDatePressed;

  final void Function(bool) onDeadlineSwitchValueChanged;

  final void Function(BuildContext) onClose;

  const TodoEditorLayout({Key? key, 
                         required this.priority,           
                         required this.priorities, 
                         required this.highPriority,
                         required this.deadline,
                         required this.isDeadlineButtonVisible,
                         required this.onPriorityValueChanged,
                         required this.onDeadlineDatePressed,
                         required this.onDeadlineSwitchValueChanged,
                         required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDeadlineDate = DateFormat('dd.MM.yyyy').format(deadline);
    var priorityDropdownMenuItems = priorities.map((string) => DropdownMenuItem<String>(
      value: string, 
      child: Text(string, style: TextStyle(color: string == highPriority ? Colors.red : Colors.black)))
    ).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            onClose(context);
          },
          icon: const Icon(Icons.close),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text(_saveButtonTitle, style: TextStyle(color: Colors.grey, fontSize: 17.0)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 26.0),
                child: TextField(
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
                  value: priority,
                  onChanged: onPriorityValueChanged,
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
                  padding: EdgeInsets.only(left: 26, top: (isDeadlineButtonVisible ? 18 : 30)),
                  child: Column(
                    children: [
                      const Text(
                        _deadlineTitle, 
                        style: TextStyle(color: Colors.black, fontSize: 17.0)
                      ),
                      Visibility(
                        child: TextButton(
                          onPressed: () => onDeadlineDatePressed(context),
                          child: Text(formattedDeadlineDate, style: const TextStyle(color: Colors.blue, fontSize: 14)),
                        ),
                        visible: isDeadlineButtonVisible,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 26, top: 0),
                  child: Switch(
                    value: isDeadlineButtonVisible,
                    onChanged: onDeadlineSwitchValueChanged,
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
                  onPressed: () {},
                  child: RichText(
                    text: const TextSpan(
                    children: [
                      WidgetSpan(child: Icon(Icons.delete, size: 18, color: Colors.grey)),
                      TextSpan(
                        text: _deleteButtonTitle, 
                        style: TextStyle(color: Colors.grey, fontSize: 17.0)
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
}
