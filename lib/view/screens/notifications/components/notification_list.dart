import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/notification_ctrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/model/models/notificaion_model.dart';
import 'package:epics/view/screens/profile/user_profile.dart';
import 'package:epics/view/screens/search/components/list_images_post.dart';
import 'package:epics/view/screens/search/components/single_post_image.dart';
import 'package:epics/view/screens/userProfile/userprofile.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<NotificationsController>(
        init: NotificationsController(),
        builder: (controller) {
          if (controller.loading.value) {
            return SizedBox(
                height: Get.height * 0.8,
                child: Center(child: CircularProgressIndicator()));
          }
          return Container(
            child: Expanded(
              child: controller.notifications.length != 0
                  ? ListView.builder(
                      itemCount: controller.notifications.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        NotificationModel model =
                            controller.notifications[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: GestureDetector(
                              onTap: () => model.userInfo.userId !=
                                      Get.find<AuthController>().userUid.value
                                  ? Get.to(() => OtherUserProfile(
                                        userModel: model.userInfo,
                                      ))
                                  : Get.to(() => UserProfile()),
                              child: Text(model.userInfo.userName,
                                  style: Theme.of(context).textTheme.button),
                            ),
                            subtitle: Text(
                                model.notificationType == 'like'
                                    ? 'Liked your post'
                                    : model.notificationType == 'comment'
                                        ? 'Commented on your post'
                                        : model.notificationType == 'follow'
                                            ? 'Started following you'
                                            : '',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.5)),
                            onTap: () {
                              if (model.posts.imageList.length == 1) {
                                model.posts.userInfo =
                                    Get.find<UserInfoController>()
                                        .usetInfo
                                        .value;
                                model.posts.userInfo = model.userInfo;
                                Get.to(() => SingleImagePost(
                                      postmodel: model.posts,
                                      index: index,
                                    ));
                              } else {
                                model.posts.userInfo =
                                    Get.find<UserInfoController>()
                                        .usetInfo
                                        .value;

                                Get.to(() => PostofImageList(
                                      postmodel: model.posts,
                                    ));
                              }
                            },
                            leading: model.userInfo.userAvatar != null
                                ? GestureDetector(
                                    onTap: () => Get.to(
                                      () => FullImagePreview(
                                          imageUrl: NETWORK_IMAGE_URL +
                                              '${model.userInfo.userAvatar}',
                                          blurHash: model.userInfo.blurHash),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(99),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: BlurHash(
                                          image: NETWORK_IMAGE_URL +
                                              '${model.userInfo.userAvatar}',
                                          hash: model.userInfo.blurHash,
                                        ),
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(99),
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        'assets/default.jpeg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                            trailing: model.notificationType == 'like' ||
                                    model.notificationType == 'comment'
                                ? GestureDetector(
                                    onTap: () => Get.to(
                                      () => FullImagePreview(
                                          imageUrl: NETWORK_IMAGE_URL +
                                              '${model.posts.imageList[0]}',
                                          blurHash: model.posts.blurHash[0]),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: BlurHash(
                                          image: NETWORK_IMAGE_URL +
                                              '${model.posts.imageList[0]}',
                                          hash: model.posts.blurHash[0],
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Notifications',
                              style: Theme.of(context).textTheme.headline6),
                          SizedBox(height: Get.height * 0.01),
                          Text('No Notificaation to show',
                              style: Theme.of(context).textTheme.caption)
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}

class FollowButton extends StatelessWidget {
  const FollowButton({
    this.value,
    Key key,
  }) : super(key: key);
  final bool value;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        print(value);
      },
      highlightColor: Theme.of(context).primaryColor,
      child: Container(
        width: SizeConfig.widthMultiplier * 25,
        height: SizeConfig.heightMultiplier * 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
              colors: value
                  ? [
                      Theme.of(context).secondaryHeaderColor,
                      Theme.of(context).secondaryHeaderColor
                    ]
                  : primaryGradient),
        ),
        // padding:
        //     EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Center(
          child: Text(
            value ? 'Following' : 'Follow',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: value
                    ? Theme.of(context).accentColor
                    : Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
