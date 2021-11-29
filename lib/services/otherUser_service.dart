import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/model/models/follow_model.dart';
import 'package:epics/model/models/notificaion_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtherUserService {
  getUserFollowers(String uid) async {
    return await Supabase.instance.client
        .from('follow')
        .select('*')
        // .select('*,user_from(user_name),user_to(user_name)')
        .or('user_from.eq.$uid,user_to.eq.$uid')
        .execute();
  }

  getUsersPost(String userId) async {
    print(userId + "  " + Get.find<AuthController>().userUid.value);
    return Supabase.instance.client.rpc('getspecificuserposts', params: {
      'currentuseruid': Get.find<AuthController>().userUid.value,
      'specific_user_uid': userId,
    }).execute();
  }

  followUser(String userUid) {
    String currentUserUid = Get.find<AuthController>().userUid.value;
    print(userUid + '\t\t' + currentUserUid);
    if (userUid != currentUserUid) {
      NotificationModel notificationModel = NotificationModel(
        userto: userUid,
        userfrom: currentUserUid,
        postId: null,
        notificationType: 'follow',
        createdOn: DateTime.now(),
      );
      Supabase.instance.client
          .from('notifications')
          .insert([notificationModel.toMap()])
          .execute()
          .then((value) {
            print(value.data);
            print(value.error.message);
          });
    }

    FollowModel followModel = FollowModel(
        userFrom: currentUserUid,
        userTo: userUid,
        followingBack: false.toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    Supabase.instance.client
        .from('follow')
        .insert([followModel.toMap()])
        .execute()
        .then((value) => {Get.find<PostController>().onInit()});
  }

  unFollowUser(String userUid) async {
    String currentUserUid = Get.find<AuthController>().userUid.value;

    return await Supabase.instance.client
        .from('follow')
        .delete()
        .match({'user_from': currentUserUid, 'user_to': userUid})
        .execute()
        .then((value) {
          print(value.data);
          print(value.error);
        });
  }
}
