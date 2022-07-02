import 'package:flutter/material.dart';

const _deleteButtonTitle = ' DELETE';

class TodoEditorDeleteButton extends StatelessWidget {

  final bool canTodoItemBeRemoved;
  final void Function() onButtonPressed;

  const TodoEditorDeleteButton({
    Key? key,
    required this.canTodoItemBeRemoved,
    required this.onButtonPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 14, top: 24),
        child: TextButton(
          onPressed: canTodoItemBeRemoved
              ? () => onButtonPressed()
              : null,
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(child: Icon(Icons.delete, size: 18, color: _textColor)),
                TextSpan(
                  text: _deleteButtonTitle,
                  style: TextStyle(color: _textColor, fontSize: 17.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color get _textColor => canTodoItemBeRemoved
                            ? Colors.red
                            : Colors.grey;
}
