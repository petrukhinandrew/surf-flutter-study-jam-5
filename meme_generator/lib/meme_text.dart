import 'package:flutter/material.dart';

class MemeText extends StatefulWidget {
  const MemeText({super.key});

  @override
  State<MemeText> createState() => _MemeTextState();
}

class _MemeTextState extends State<MemeText> {
  final _textKey = GlobalKey();
  final _textController = TextEditingController(
      text: 'Your meme could be here Your meme could be here');

  double _fontSize = 40;
  final _textStyle = const TextStyle(
    fontFamily: 'Impact',
    color: Colors.white,
  );
  @override
  void initState() {
    super.initState();
  }

  void _textChanged(String _) {
    final inputWidth = _textKey.currentContext!.size!.width - 50;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: _textController.text,
        style: const TextStyle(
          fontFamily: 'Impact',
          color: Colors.white,
        ),
      ),
    );
    textPainter.layout();

    double textWidth = textPainter.width;
    double fontSize = 40;

    while (textWidth > inputWidth && fontSize > 1.0) {
      fontSize -= 0.5;
      textPainter.text = TextSpan(
        text: _textController.text,
        style: _textStyle.copyWith(fontSize: fontSize),
      );
      textPainter.layout();
      textWidth = textPainter.width;
    }

    setState(() {
      _fontSize = fontSize;
    });
  }

  final node = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minHeight: 100,
      ),
      child: EditableText(
        key: _textKey,
        onChanged: _textChanged,
        controller: _textController,
        focusNode: node,
        cursorColor: Colors.white,
        maxLines: 1,
        backgroundCursorColor: Colors.white,
        textAlign: TextAlign.center,
        style: _textStyle.copyWith(fontSize: _fontSize),
      ),
    );
  }
}
