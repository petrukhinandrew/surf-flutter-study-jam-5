import 'package:flutter/material.dart';

class MemeText extends StatelessWidget {
  const MemeText({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = TextEditingController(
        text: 'Здесь мог бы быть ваш мем Здесь мог бы быть ваш мем');
    final node = FocusNode();
    return EditableText(
      controller: ctrl,
      focusNode: node,
      cursorColor: Colors.white,
      backgroundCursorColor: Colors.white,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Impact',
        fontSize: 40,
        color: Colors.white,
      ),
    );
  }
}
