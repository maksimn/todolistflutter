import 'package:flutter/material.dart';

const _textHint = 'Enter a text...';

class TodoEditorTextInput extends StatelessWidget {

  final String text;
  final void Function(String)? onTextChanged;

  final _textEditingController = TextEditingController();
  
  TodoEditorTextInput({
    Key? key,
    this.text = '', 
    this.onTextChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = text;
    _textEditingController.selection = TextSelection.fromPosition(TextPosition(
      offset: _textEditingController.text.length
    ));
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 26.0),
      child: TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: _textHint,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          )
        ),
        keyboardType: TextInputType.multiline,
        minLines: 8,
        maxLines: 8,
        onChanged: onTextChanged,
      )
    );
  }
}
