import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TodoEditorWidget extends StatefulWidget {
  const TodoEditorWidget({Key? key}) : super(key: key);

  @override
  _TodoEditorWidgetState createState() => _TodoEditorWidgetState();
}

const normalPriorityString = "no";
const lowPriorityString = "low";
const highPriorityString = "!! high";

class _TodoEditorWidgetState extends State<TodoEditorWidget> {
  String? priorityValue = normalPriorityString;
  bool isDeadlineButtonVisible = false;
  DateTime deadlineDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String formattedDeadlineDate = DateFormat('dd.MM.yyyy').format(deadlineDate);
    var priorityDropdownMenuItems = const [
      DropdownMenuItem<String>(
        value: normalPriorityString,
        child: Text(normalPriorityString),
      ),
      DropdownMenuItem<String>(
        value: lowPriorityString,
        child: Text(lowPriorityString),
      ),
      DropdownMenuItem<String>(
        value: highPriorityString,
        child: Text(highPriorityString, style: TextStyle(color: Colors.red)),
      )
    ].toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            _close(context);
          },
          icon: const Icon(Icons.close),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text("SAVE    ", style: TextStyle(color: Colors.grey, fontSize: 17.0)),
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
                      hintText: "Enter a text...",
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
                child: Text("Priority", style: TextStyle(color: Colors.black, fontSize: 17.0)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 26),
                child: DropdownButton<String>(
                  items: priorityDropdownMenuItems,
                  value: priorityValue,
                  onChanged: _onPriorityValueChanged,
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
                      const Text("Deadline", style: TextStyle(color: Colors.black, fontSize: 17.0)),
                      Visibility(
                        child: TextButton(
                          onPressed: () => _selectDate(context),
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
                    onChanged: _onDeadlineSwitchValueChanged,
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
                      TextSpan(text: " DELETE", style: TextStyle(color: Colors.grey, fontSize: 17.0)),
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

  void _close(BuildContext context) {
    Navigator.pop(context);
  }

  void _onPriorityValueChanged(String? newValue) {
    setState(() {
      priorityValue = newValue;
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
