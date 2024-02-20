import 'package:flutter/material.dart';
import 'package:meme_generator/meme_image.dart';
import 'package:meme_generator/meme_text.dart';
import 'package:meme_generator/meme_wrapper.dart';

class MemeWidget extends StatelessWidget {
  const MemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MemeWrapper(children: [MemeImage(), MemeText()]);
  }
}
