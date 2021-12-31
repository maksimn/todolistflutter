import 'package:flutter/material.dart';

class TodoEditorWidget extends StatelessWidget {
  const TodoEditorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Дело"),
      ),
      body: const SizedBox.shrink(),
    );
  }
}
