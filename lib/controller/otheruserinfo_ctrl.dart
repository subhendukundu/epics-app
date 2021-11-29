import 'package:epics/model/models/post_model.dart';
import 'package:epics/services/otherUser_service.dart';
import 'package:get/get.dart';

class OtherUserInfoCtrl extends GetxController {
  RxInt followers = 0.obs;
  RxInt followings = 0.obs;
  RxList<PostsModel> getUsersPost = <PostsModel>[].obs;
  RxBool isPostLoading = true.obs;
  RxBool isFollowLoading = true.obs;

  getUserData(String userId) {
    getUsersPost.value = <PostsModel>[].obs;
    isPostLoading.value = true;
    getSpecialUserData(userId);
    getUsersPosts(userId);
  }

  getSpecialUserData(String userUid) {
    followers.value = 0;
    followings.value = 0;
    OtherUserService().getUserFollowers(userUid).then((value) {
      value.data.forEach((val) {
        if (val['user_from'] == userUid) {
          followings.value += 1;
        } else {
          followers.value += 1;
        }
      });
      isFollowLoading.value = false;
    });
  }

  getUsersPosts(String userUid) {
    // print(userUid);
    OtherUserService().getUsersPost(userUid).then((value) {
      // print(value.data);
      if (value.data != null)
        value.data.forEach((e) {
          PostsModel postModel = PostsModel.fromMap(e);
          // if (postModel.privacy != 'Only me') {
          getUsersPost.value.add(postModel);
          // }
        });
    });
    isPostLoading.value = false;
  }
}
