import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainTodoListWidget extends StatefulWidget {
  const MainTodoListWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainTodoListWidget> createState() => _MainTodoListWidgetState();
}

class _MainTodoListWidgetState extends State<MainTodoListWidget> {
  void _onPlusButtonPressed() {
    if (kDebugMode) {
      print('Plus button pressed on main screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPlusButtonPressed,
        tooltip: 'Create new Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}