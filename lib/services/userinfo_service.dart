import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/model/models/userinfo.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserInfoService {
  // getuser() async {
  //   final responce =
  //       await Supabase.instance.client.from('posts').select().execute();
  //   print(responce.data);
  // }

  addUsertoTable(String email, String uid) {
    UserInfoModel userModel = UserInfoModel(
      // email: email,
      userId: uid,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastSeen: DateTime.now(),
      isActive: true,
    );
    try {
      Supabase.instance.client.from('user_info').insert([
        userModel.toMap(),
      ]).execute();
    } catch (e) {
      print(e.toString());
    }
    print(userModel.toMap());
  }

  getAllUsers() {
    return Supabase.instance.client.from('user_info').select().execute();
  }

  getUserFollowers() {
    return Supabase.instance.client
        .from('follow')
        .select('user_from')
        .eq("user_to", Get.find<AuthController>().userUid)
        .execute();
  }

  getUserFollowersData() {
    return Supabase.instance.client
        .from('follow')
        .select(
            'user_from(user_name, user_avatar,user_avatar_blurhash,user_id)')
        .eq("user_to", Get.find<AuthController>().userUid)
        .execute();
  }
}
