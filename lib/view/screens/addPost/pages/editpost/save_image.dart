import 'dart:io';
import 'dart:typed_data';
import 'package:blurhash/blurhash.dart';
import 'package:epics/controller/add_post_Ctrl.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:share/share.dart';

class SaveImageScreen extends StatefulWidget {
  final List arguments;
  final int index;
  SaveImageScreen({this.arguments, this.index});
  @override
  _SaveImageScreenState createState() => _SaveImageScreenState();
}

class _SaveImageScreenState extends State<SaveImageScreen> {
  File image;
  bool savedImage;
  @override
  void initState() {
    super.initState();
    image = widget.arguments[0];
    savedImage = false;
    saveImage();
  }

  Future saveImage() async {
    renameImage();
    await GallerySaver.saveImage(image.path, albumName: "PhotoEditor");
    setState(() {
      savedImage = true;
    });
  }

  void renameImage() {
    String ogPath = image.path;
    List<String> ogPathList = ogPath.split('/');
    String ogExt = ogPathList[ogPathList.length - 1].split('.')[1];
    DateTime today = new DateTime.now();
    String dateSlug =
        "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year.toString()}_${today.hour.toString().padLeft(2, '0')}-${today.minute.toString().padLeft(2, '0')}-${today.second.toString().padLeft(2, '0')}";
    image = image.renameSync(
        "${ogPath.split('/image')[0]}/PhotoEditor_$dateSlug.$ogExt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "Export Photo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: GetBuilder<AddPostCtrl>(
                init: AddPostCtrl(),
                builder: (controller) {
                  return IconButton(
                    onPressed: () async {
                      ImageUploadModel imageModel =
                          ImageUploadModel(imageFile: image, imageUrl: '');
                      controller.images[widget.index] = imageModel;
                      Uint8List pixels = await image.readAsBytes();
                      var blurHash = await BlurHash.encode(pixels, 4, 4);
                      controller.blurHashList[widget.index] = blurHash;
                      Get.back();
                    },
                    icon: Icon(
                      Icons.done,
                      color: Colors.black,
                    ),
                  );
                }),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Container(
                color: Theme.of(context).hintColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.9,
                child: PhotoView(
                  imageProvider: FileImage(image),
                  backgroundDecoration: BoxDecoration(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
