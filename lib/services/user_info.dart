import 'dart:io';
import 'dart:typed_data';
import 'package:blurhash/blurhash.dart';
import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/model/models/blurimage_model.dart';
import 'package:epics/model/models/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserInfoService {
  Future<UserInfoModel> getCurrentUserData() {
    return Supabase.instance.client
        .from('user_info')
        .select('*')
        .eq('user_id', Get.find<AuthController>().userUid.value)
        .maybeSingle()
        .execute()
        .then((value) {
      // print(value.data);
      if (value.error == null) {
        UserInfoModel model;
        model = UserInfoModel.fromMap(value.data);

        return model;
      } else {
        Get.snackbar('ERROR', value.error.message);
        return null;
      }
    });
  }

  Future<void> uploadImage(File image, String name, String bio) async {
    var uniqueId = UniqueKey().toString().substring(2, 7);
    String bucketName = 'avatar';

    final fileName = 'public/$uniqueId.jpg';
    final bytes = await image.readAsBytes();
    const fileOptions = FileOptions(upsert: true);
    // print(fileName);
    try {
      await Supabase.instance.client.storage
          .from(bucketName)
          .uploadBinary(fileName, bytes, fileOptions: fileOptions)
          .then((value) {
        addToUserTable(image, fileName, name, bio);

        // print(value.data);
        // print(value.error.message);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  addToUserTable(File file, String fileName, String name, String bio) async {
    Uint8List pixels = await file.readAsBytes();
    var blurHash = await BlurHash.encode(pixels, 6, 6);
    BlurImageModel blurImage =
        BlurImageModel(filepath: fileName, hash: blurHash);
    String tableName = 'user_info';
    // print(blurImage.filepath);
    final updates = {
      'user_avatar': blurImage.filepath,
      'user_avatar_blurhash': blurImage.hash,
      'updated_at': DateTime.now().toIso8601String(),
      'user_name': name,
      'bio': bio
    };

    await Supabase.instance.client
        .from(tableName)
        .update(updates)
        .match({'user_id': Get.find<AuthController>().userUid})
        .execute()
        .then((value) {
          print(value.data);
          Get.find<UserInfoController>().usetInfo.value =
              UserInfoModel.fromMap(value.data[0]);
        });
  }

  updateNameBio(String name, String bio) async {
    final updates = {
      'updated_at': DateTime.now().toIso8601String(),
      'user_name': name.toLowerCase(),
      'bio': bio
    };
    String tableName = 'user_info';

    await Supabase.instance.client
        .from(tableName)
        .update(updates)
        .match({'user_id': Get.find<AuthController>().userUid})
        .execute()
        .then((value) {
          Get.put(UserInfoController());
          Get.find<UserInfoController>().usetInfo.value =
              UserInfoModel.fromMap(value.data[0]);
        });
  }

  getcomment() {
    Supabase.instance.client
        .from('notifications')
        .select('*,user_from(*),posts(*)')
        .eq('user_to', '2f4e251d-37b6-4e98-996e-15740220d784')
        .execute()
        .then((value) {
      debugPrint("NOTIFICATION ${value.data}", wrapWidth: 20000);
      // print(value.error.message);
    });
  }

  checkIfUserNameExits(String userName) async {
    return await Supabase.instance.client
        .from('user_info')
        .select('user_name')
        .eq('user_name', userName)
        .execute()
        .then((value) {
      print(value.data);
      if (value.data.length != 0) {
        return false;
      } else {
        return true;
      }
    });
  }
}
