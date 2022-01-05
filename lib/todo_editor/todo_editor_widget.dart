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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 26.0),
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Что надо сделать...",
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
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
                child: Text("Важность", style: TextStyle(color: Colors.black, fontSize: 17.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }
}
