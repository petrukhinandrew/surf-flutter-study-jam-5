import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meme_generator/meme_widget.dart';
import 'package:path_provider/path_provider.dart';

class MemeGeneratorScreen extends StatelessWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kek = GlobalKey();
    return Scaffold(
      backgroundColor: Colors.black,
      body: RepaintBoundary(
        key: kek,
        child: const MemeWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton.outlined(
          onPressed: () async {
            final res = await _makeScreenshotAndSave(kek);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(res ? "Demo saved" : "Error occured")));
            }
          },
          icon: const Icon(Icons.save_alt),
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  side: BorderSide(width: 4),
                  borderRadius: BorderRadius.all(Radius.circular(4)))),
              iconColor: MaterialStatePropertyAll(Colors.white),
              backgroundColor: MaterialStatePropertyAll(Colors.black)),
        ),
      ),
    );
  }

  Future<bool> _makeScreenshotAndSave(GlobalKey kek) async {
    try {
      final lol =
          kek.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final imageBytes = await lol
          .toImage()
          .then((value) => value.toByteData(format: ui.ImageByteFormat.png));
      print("Widget mapped to bytes");
      if (imageBytes != null) {
        print("Bytes are not null");
        final bytes = imageBytes.buffer.asUint8List();
        if (Platform.isAndroid || Platform.isIOS) {
          print("Saving to gallery");
          ImageGallerySaver.saveImage(bytes);
          print("Saved");
        } else {
          final dt = DateTime.now();
          final fName =
              "demo${dt.day}-${dt.month}-${dt.year}-${dt.hour}-${dt.minute}-${dt.second}";
          final dir = await getDownloadsDirectory();
          final dirPath = dir!.path;
          print("got dir $dirPath");
          final fullFNamePath =
              dirPath + Platform.pathSeparator + fName + ".png";
          final _ = await File(fullFNamePath).writeAsBytes(bytes, flush: true);
          print("written file");
        }
        return true;
      }
    } catch (e) {
      print("got err $e");
    }
    return false;
  }
}
