import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart' hide File;
import 'package:get/get.dart';
import 'dart:io';

class FullImagePreview extends StatelessWidget {
  const FullImagePreview(
      {Key key, this.imageUrl, this.blurHash, this.imageFile})
      : super(key: key);
  final String imageUrl;
  final String blurHash;
  final File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: imageFile == null
            ? BlurHash(
                hash: blurHash,
                image: imageUrl,
                imageFit: BoxFit.contain,
              )
            : Image.file(
                imageFile,
                // height: SizeConfig.heightMultiplier * 15,
                // width: SizeConfig.widthMultiplier * 30,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
