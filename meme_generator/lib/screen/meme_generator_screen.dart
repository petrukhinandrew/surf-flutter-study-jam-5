import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meme_generator/meme_widget.dart';
import 'package:meme_generator/meme_wrapper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  @override
  void initState() {
    super.initState();
    Permission.manageExternalStorage.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const MemeWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton.outlined(
          onPressed: () async {
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Saving demo")));
            }
            final res = await _makeScreenshotAndSave(screenshotKey);
            await Future.delayed(const Duration(milliseconds: 500));
            if (context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(res ? "Demo saved" : "Error occured")));
            }
          },
          icon: const Icon(Icons.save_alt),
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 4),
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
          .toImage(pixelRatio: 3)
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
