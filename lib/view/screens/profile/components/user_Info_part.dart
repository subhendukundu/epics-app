import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'bottom_sheet.dart';
import 'fadeanimation.dart';
import 'profileInfo.dart';

class UserInfoPart extends StatelessWidget {
  const UserInfoPart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.heightMultiplier * 4,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => showMaterialModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => BottomModelSheet(),
                      ),
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        Container(
          height: SizeConfig.heightMultiplier * 20,
          child: Center(
            child: FadeAnimation(
              delay: 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GetX<UserInfoController>(
                      init: UserInfoController(),
                      builder: (controller) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: SizeConfig.widthMultiplier * 20,
                            height: SizeConfig.heightMultiplier * 10,
                            child: controller.usetInfo.value.userAvatar != null
                                ? GestureDetector(
                                    onTap: () => Get.to(
                                      () => FullImagePreview(
                                          imageUrl: NETWORK_IMAGE_URL +
                                              '${controller.usetInfo.value.userAvatar}',
                                          blurHash: controller
                                              .usetInfo.value.blurHash),
                                    ),
                                    child: BlurHash(
                                      image: NETWORK_IMAGE_URL +
                                          '${controller.usetInfo.value.userAvatar}',
                                      hash: controller.usetInfo.value.blurHash,
                                    ),
                                  )
                                : Image.asset('assets/default.jpeg'),
                          ),
                        );
                      }),
                  GetX<UserInfoController>(
                      init: UserInfoController(),
                      builder: (controller) {
                        return Text(controller.usetInfo.value.userName ?? '',
                            style: Theme.of(context).textTheme.bodyText1);
                      }),
                  GetX<UserInfoController>(
                      init: UserInfoController(),
                      builder: (controller) {
                        return Text(controller.usetInfo.value.bio ?? '',
                            style: Theme.of(context).textTheme.bodyText1);
                      }),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 3),
        SizedBox(
          width: Get.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeAnimation(
                delay: 0.4,
                child: GetX<PostController>(
                    init: PostController(),
                    builder: (controller) {
                      return ProfileInfo(
                        value: controller.myPostsList.length,
                        title: 'Post',
                      );
                    }),
              ),
              FadeAnimation(
                delay: 0.6,
                child: GetX<UserInfoController>(
                    init: UserInfoController(),
                    builder: (controller) {
                      return ProfileInfo(
                        value: controller.followingList.length,
                        title: 'Following',
                      );
                    }),
              ),
              FadeAnimation(
                delay: 0.8,
                child: GetX<UserInfoController>(
                    init: UserInfoController(),
                    builder: (controller) {
                      return ProfileInfo(
                        value: controller.followersList.length,
                        title: 'Followers',
                      );
                    }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
