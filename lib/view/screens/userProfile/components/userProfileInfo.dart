import 'package:epics/controller/followuser.dart';
import 'package:epics/controller/otheruserinfo_ctrl.dart';

import 'package:epics/model/models/userinfo.dart';
import 'package:epics/view/screens/profile/components/fadeanimation.dart';
import 'package:epics/view/screens/profile/components/profileInfo.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' hide AnimatedScale;
import 'package:get/get.dart';

class UserProfileInfo extends StatefulWidget {
  const UserProfileInfo({
    Key key,
    this.userModel,
  }) : super(key: key);
  final UserInfoModel userModel;

  @override
  _UserProfileInfoState createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: SizeConfig.heightMultiplier * 20,
          child: Center(
            child: FadeAnimation(
              delay: 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: SizeConfig.widthMultiplier * 20,
                      height: SizeConfig.heightMultiplier * 10,
                      child: widget.userModel.userAvatar != null
                          ? GestureDetector(
                              onTap: () => Get.to(
                                () => FullImagePreview(
                                    imageUrl: NETWORK_IMAGE_URL +
                                        '${widget.userModel.userAvatar}',
                                    blurHash: widget.userModel.blurHash),
                              ),
                              child: BlurHash(
                                image: NETWORK_IMAGE_URL +
                                    '${widget.userModel.userAvatar}',
                                hash: widget.userModel.blurHash,
                              ),
                            )
                          : Image.asset('assets/default.jpeg'),
                    ),
                  ),
                  Text(widget.userModel.userName ?? '',
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(widget.userModel.bio ?? '',
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 1),
        SizedBox(
          width: Get.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeAnimation(
                delay: 0.4,
                child: GetX<OtherUserInfoCtrl>(
                    init: OtherUserInfoCtrl(),
                    builder: (controller) {
                      return ProfileInfo(
                        value: controller.getUsersPost.length ?? '',
                        title: 'Post',
                      );
                    }),
              ),
              FadeAnimation(
                delay: 0.6,
                child: GetX<OtherUserInfoCtrl>(
                    init: OtherUserInfoCtrl(),
                    builder: (controller) {
                      return ProfileInfo(
                        value: controller.followings.value ?? '',
                        title: 'Following',
                      );
                    }),
              ),
              FadeAnimation(
                delay: 0.8,
                child: GetX<OtherUserInfoCtrl>(
                    init: OtherUserInfoCtrl(),
                    builder: (controller) {
                      return ProfileInfo(
                        value: controller.followers.value ?? '',
                        title: 'Followers',
                      );
                    }),
              )
            ],
          ),
        ),
        GetX<FollowUserCtrl>(
            init: FollowUserCtrl(userUid: widget.userModel.userId),
            builder: (controller) {
              return RawMaterialButton(
                onPressed: () {
                  controller.changeUserstatus();
                  Get.find<OtherUserInfoCtrl>()
                      .getSpecialUserData(widget.userModel.userId);
                },
                fillColor:
                    controller.followed.value ? Colors.white : PINK_COLOR,
                constraints: BoxConstraints(
                  maxWidth: Get.width * 0.8,
                  minWidth: Get.width * 0.8,
                  minHeight: Get.height * 0.05,
                  maxHeight: Get.height * 0.05,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  controller.followed.value ? 'Following' : 'Follow',
                  style: TextStyle(
                    color:
                        controller.followed.value ? Colors.black : Colors.white,
                  ),
                ),
              );
            }),
      ],
    );
  }
}
