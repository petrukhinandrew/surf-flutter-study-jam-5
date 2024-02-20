import 'package:flutter/material.dart';

class MemeImage extends StatefulWidget {
  const MemeImage({super.key});

  @override
  State<MemeImage> createState() => _MemeImageState();
}

class _MemeImageState extends State<MemeImage> {
  String _currentUrl =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';

  void _showUrlSelectionDialog(BuildContext context) {
    print("showing url selection");
    final ctrl = TextEditingController();
    final dialog = AlertDialog(
      title: Text("Введите URL"),
      content: TextField(
        controller: ctrl,
      ),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                _currentUrl = ctrl.text.trim();
              });
              Navigator.of(context).pop();
            },
            child: Text("Save")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"))
      ],
    );
    showDialog(context: context, builder: (ctx) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _showUrlSelectionDialog(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 200),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.white,
                width: 2,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.network(
              _currentUrl,
              loadingBuilder: (_, child, event) =>
                  ((event?.expectedTotalBytes ?? 0) !=
                          (event?.cumulativeBytesLoaded ?? 0))
                      ? const Center(
                          child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                        )
                      : child,
              errorBuilder: (ctx, child, stacktrace) => const Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Произошла ошибка. \nПроверьте подключение к интернету и корректность ссылки",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Impact',
                    ),
                  ),
                ),
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
