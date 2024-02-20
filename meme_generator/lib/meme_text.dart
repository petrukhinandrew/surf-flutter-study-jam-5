import 'package:flutter/material.dart';

class MemeText extends StatelessWidget {
  const MemeText({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minHeight: 100,
      ),
      child: EditableText(
        controller: TextEditingController(text: 'Your meme could be here'),
        focusNode: FocusNode(),
        cursorColor: Colors.white,
        maxLines: 3,
        backgroundCursorColor: Colors.white,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Impact',
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
