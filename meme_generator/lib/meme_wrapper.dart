import 'package:flutter/material.dart';

final screenshotKey = GlobalKey();

class MemeWrapper extends StatelessWidget {
  final List<Widget> children;
  const MemeWrapper({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: Colors.black,
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Center(
      child: RepaintBoundary(
        key: screenshotKey,
        child: DecoratedBox(
            decoration: decoration,
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min, children: children))),
      ),
    );
  }
}
