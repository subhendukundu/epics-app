import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/model/models/userinfo.dart';
import 'package:epics/services/otherUser_service.dart';
import 'package:epics/services/user_info.dart';
import 'package:epics/view/screens/getName/userName.dart';
import 'package:get/get.dart';

import 'auth_ctrl.dart';

class UserInfoController extends GetxController {
  Rx<UserInfoModel> usetInfo = UserInfoModel().obs;
  RxBool homePageLoading = true.obs;
  RxList<String> followersList = <String>[].obs;
  RxList<String> followingList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    UserInfoService().getCurrentUserData().then((val) {
      usetInfo.value = val;
      if (val.userName == null || val.userName == '') {
        Get.to(() => GetUserName());
      } else {
        getUserFollowers();
      }
    });
  }

  getUserFollowers() {
    String userID = Get.find<AuthController>().userUid.value;
    OtherUserService().getUserFollowers(userID).then((value) {
      value.data.forEach((val) {
        if (val['user_from'] == userID) {
          followingList.value.add(val['user_to']);
        }
        if (val['user_to'] == userID) {
          followersList.value.add(val['user_from']);
        }
      });
      Get.put(PostController());
      homePageLoading.value = false;
    });
  }
}
