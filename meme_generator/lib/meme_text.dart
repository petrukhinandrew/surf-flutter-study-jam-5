import 'package:flutter/material.dart';

class MemeText extends StatelessWidget {
  const MemeText({super.key});

  @override
  Widget build(BuildContext context) {
    final _textController =
        TextEditingController(text: 'Your meme could be here');

    final _textStyle = const TextStyle(
      fontFamily: 'Impact',
      fontSize: 30,
      color: Colors.white,
    );

    final node = FocusNode();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minHeight: 100,
      ),
      child: EditableText(
        controller: _textController,
        focusNode: node,
        cursorColor: Colors.white,
        maxLines: 3,
        backgroundCursorColor: Colors.white,
        textAlign: TextAlign.center,
        style: _textStyle,
      ),
    );
  }
}
