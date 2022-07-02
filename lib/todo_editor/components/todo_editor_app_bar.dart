import 'package:flutter/material.dart';

const _saveButtonTitle = 'SAVE    ';

class TodoEditorAppBar extends AppBar {

  final void Function()? onCloseButtonPressed;
  final void Function()? onSaveButtonPressed;
  final Color? saveButtonTitleColor;

  TodoEditorAppBar({
    Key? key,
    this.onCloseButtonPressed,
    this.onSaveButtonPressed,
    this.saveButtonTitleColor
  }) : super(
    key: key,
    backgroundColor: const Color(0xfff2f2f2),
    elevation: 0.5,
    iconTheme: const IconThemeData(color: Colors.black),
    leading: IconButton(
      onPressed: onCloseButtonPressed,
      icon: const Icon(Icons.close),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: onSaveButtonPressed,
          child: Text(
            _saveButtonTitle, 
            style: TextStyle(
              color: saveButtonTitleColor, 
              fontSize: 17.0
            )
          ),
      ),
    ],
  );
}
