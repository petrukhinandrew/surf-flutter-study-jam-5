import 'package:flutter/material.dart';

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
        child: DecoratedBox(
            decoration: decoration,
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children))));
  }
}
