import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MemeImage extends StatefulWidget {
  const MemeImage({super.key});

  @override
  State<MemeImage> createState() => _MemeImageState();
}

enum MemeImageOrigin {
  net,
  gallery;
}

class _MemeImageState extends State<MemeImage> {
  String _currentUrl =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';
  XFile? _galleryAsset;
  MemeImageOrigin _origin = MemeImageOrigin.net;

  void _showUrlSelectionDialog(BuildContext context) {
    print("showing url selection");
    const textStyle = TextStyle(color: Colors.white, fontFamily: "Impact");
    const buttonStyle = ButtonStyle(
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)))),
    );
    final ctrl = TextEditingController();
    final dialog = AlertDialog(
      title: const Text("Enter URL "),
      backgroundColor: Colors.black,
      titleTextStyle: textStyle,
      content: TextField(
        controller: ctrl,
        style: textStyle,
        cursorColor: Colors.white,
      ),
      actions: [
        TextButton(
            style: buttonStyle,
            onPressed: () async {
              _galleryAsset =
                  (await ImagePicker().pickImage(source: ImageSource.gallery));
              if (_galleryAsset == null) return;
              setState(() {
                _origin = MemeImageOrigin.gallery;
              });
              Navigator.of(context).pop();
            },
            child: const Text(
              "Select from gallery",
              style: textStyle,
            )),
        TextButton(
            style: buttonStyle,
            onPressed: () {
              setState(() {
                _origin = MemeImageOrigin.net;
                _currentUrl = ctrl.text.trim();
              });
              Navigator.of(context).pop();
            },
            child: const Text("Save", style: textStyle)),
        TextButton(
            style: buttonStyle,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel", style: textStyle))
      ],
    );
    showDialog(context: context, builder: (ctx) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _showUrlSelectionDialog(context),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.white,
                width: 2,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: _origin == MemeImageOrigin.net
                ? _buildImageFromNetwork()
                : _buildImageFromGallery(context),
          ),
        ),
      ),
    );
  }

  Widget _errorImageText(BuildContext context) => const Center(
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
      );

  Widget _buildImageFromGallery(BuildContext context) {
    if (_galleryAsset == null) return _errorImageText(context);
    return FutureBuilder(
        future: _galleryAsset!.readAsBytes(),
        builder: (ctx, snapshot) => (snapshot.hasData)
            ? Image.memory(
                snapshot.data!,
                fit: BoxFit.contain,
              )
            : const CircularProgressIndicator());
  }

  Widget _buildImageFromNetwork() {
    return Image.network(
      _currentUrl,
      fit: BoxFit.contain,
      loadingBuilder: (_, child, event) => ((event?.expectedTotalBytes ?? 0) !=
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
      errorBuilder: (ctx, child, stacktrace) => _errorImageText(ctx),
    );
  }
}
