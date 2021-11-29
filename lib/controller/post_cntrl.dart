import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/services/post_service.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

class PostController extends GetxController {
  RxList<PostsModel> publicPostList = <PostsModel>[].obs;
  RxList<PostsModel> homePageList = <PostsModel>[].obs;
  RxList<PostsModel> myPostsList = <PostsModel>[].obs;
  RxBool loading = true.obs;

  @override
  void onInit() {
    super.onInit();

    getData();
  }

  Future<void> getData() async {
    loading.value = true;

    final authCtrl = Get.put(AuthController());
    String userID = authCtrl.userUid.value;
    publicPostList.value = [];
    homePageList.value = [];
    myPostsList.value = [];

    await PostService().getFollowingPosts(userID).then((value) {
      print(value.data);
      value.data.forEach((e) {
        PostsModel post = new PostsModel.fromMap(e);
        homePageList.add(post);
      });
    });

    await PostService().getPostsFromSearchPage().then((value) {
      value.data.forEach((e) {
        PostsModel post = new PostsModel.fromMap(e);
        publicPostList.add(post);
      });
    });
    await PostService().getCurrentUserPost(userID).then((value) {
      value.data.forEach((e) {
        PostsModel post = new PostsModel.fromMap(e);
        myPostsList.add(post);
        // homePageList.add(post);
      });
    });

    loading.value = false;
  }
}
