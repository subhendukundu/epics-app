import 'dart:io';
import 'dart:typed_data';

import 'package:blurhash/blurhash.dart';
import 'package:epics/model/models/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotify/spotify.dart';

class AddPostCtrl extends GetxController {
  // TEXT FIELD CONTROLLERS
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  final titleKey = GlobalKey<FormState>();
  final descriptionKey = GlobalKey<FormState>();
  List<String> blurHashList = [];
  RxList<String> selectedFollowers = <String>[].obs;
  List get followersList => selectedFollowers.value;
  RxBool posting = false.obs;
  RxList<UserInfoModel> searchList = <UserInfoModel>[].obs;

  final RxBool loading = false.obs;

  RxList<Object> images = [].obs;
  File imageFile;

  RxList<String> tagList = <String>[].obs;
  updateList(String newValue) {
    tagList.add(newValue);
  }

  @override
  void onInit() {
    super.onInit();
    images.add("Add Image");
  }

  List<String> privacy = ['Everyone', 'My Friends', 'Only Me'];
  RxInt seletedPrivacy = 0.obs;

  Future onAddImageClick(int index) async {
    final pickedFile =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform
            .pickImage(source: ImageSource.gallery, imageQuality: 50);
    imageFile = File(pickedFile.path);
    getFileImage(index);
  }

  void getFileImage(int index) async {
    images.add('Add Image');
    ImageUploadModel imageUpload = new ImageUploadModel();
    imageUpload.imageFile = imageFile;
    imageUpload.imageUrl = '';
    images.replaceRange(index, index + 1, [imageUpload]);

    getblurHaah();
  }

  RxBool pickedSong = false.obs;
  Track playingTrack = Track();

  songPicked(Track pickedTrack) {
    playingTrack = pickedTrack;
    print(playingTrack.name);
  }

  Track trckPickedForPost;
  RxBool songPickedforPost = false.obs;
  trackPickedForPost(Track pickedTrack) {
    trckPickedForPost = pickedTrack;
  }

  void getblurHaah() async {
    Uint8List pixels = await imageFile.readAsBytes();
    var blurHash = await BlurHash.encode(pixels, 1, 1);
    blurHashList.add(blurHash);
  }
}

class ImageUploadModel {
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.imageFile,
    this.imageUrl,
  });
}
