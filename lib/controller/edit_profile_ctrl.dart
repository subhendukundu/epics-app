import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileCtrl extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File pickedProfile;
  RxBool imagePicked = false.obs;
  Future pickProfilePicture() async {
    final pickedFile =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    pickedProfile = File(pickedFile.path);
  }
}
