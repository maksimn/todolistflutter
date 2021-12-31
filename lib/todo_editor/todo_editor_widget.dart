import 'package:flutter/material.dart';

class TodoEditorWidget extends StatelessWidget {
  const TodoEditorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const saveTextDefaultStyle = TextStyle(color: Colors.grey, fontSize: 17.0);
    const saveText = Text("СОХРАНИТЬ ", style: saveTextDefaultStyle);

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
            child: saveText,
          ),
        ],
      ),
      body: const SizedBox.shrink(),
    );
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }
}
