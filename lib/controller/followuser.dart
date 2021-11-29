import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/services/otherUser_service.dart';
import 'package:get/get.dart';

class FollowUserCtrl extends GetxController {
  FollowUserCtrl({this.userUid});
  String userUid;
  RxBool followed = false.obs;

  @override
  void onInit() {
    super.onInit();

    followed.value =
        Get.find<UserInfoController>().followingList.contains(userUid);
  }

  changeUserstatus() {
    print(followed.value);
    if (followed.value) {
      Get.find<UserInfoController>().followingList.value.remove(userUid);
      followed.value = false;
      OtherUserService().unFollowUser(userUid);
    } else {
      Get.find<UserInfoController>().followingList.value.add(userUid);
      followed.value = true;
      OtherUserService().followUser(userUid);
    }
  }
}
