import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _deadlineTitle = 'Deadline';

class TodoEditorDeadlineSelector extends StatelessWidget {

  final DateTime deadline;
  final bool isDeadlineVisible;
  final void Function() onDeadlineButtonPressed;
  final void Function(bool) onDeadlineSwitchValueChanged;

  const TodoEditorDeadlineSelector({
    Key? key,
    required this.deadline,
    required this.isDeadlineVisible,
    required this.onDeadlineButtonPressed,
    required this.onDeadlineSwitchValueChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
          Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: 26, top: (isDeadlineVisible ? 18 : 30)),
          child: Column(
            children: [
              const Text(
                _deadlineTitle,
                style: TextStyle(color: Colors.black, fontSize: 17.0)
              ),
              Visibility(
                child: TextButton(
                  onPressed: onDeadlineButtonPressed,
                  child: Text(
                      DateFormat('dd.MM.yyyy').format(deadline),
                      style: const TextStyle(color: Colors.blue, fontSize: 14)
                  ),
                ),
                visible: isDeadlineVisible,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 26, top: 0),
          child: Switch(
            value: isDeadlineVisible,
            onChanged: (value) => onDeadlineSwitchValueChanged(value),
          ),
        ),
      ]),
    );
  }
}
