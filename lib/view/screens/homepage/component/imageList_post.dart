import 'dart:async';
import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/playaudio_ctrl.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/view/screens/homepage/component/bottom_funtionalality.dart';
import 'package:epics/view/screens/homepage/component/pic_slider.dart';
import 'package:epics/view/screens/profile/user_profile.dart';
import 'package:epics/view/screens/userProfile/userprofile.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class ListImagesPost extends StatelessWidget {
  ListImagesPost({Key key, this.postmodel}) : super(key: key);

  final PostsModel postmodel;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16, left: 12, bottom: 16),
        // height: SizeConfig.heightMultiplier * 45,
        // color: Colors.black,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => postmodel.userInfo.userId !=
                      Get.find<AuthController>().userUid.value
                  ? Get.to(() => OtherUserProfile(
                        userModel: postmodel.userInfo,
                      ))
                  : Get.to(() => UserProfile()),
              //            Get.to(() => OtherUserProfile(
              //   userModel: postmodel.userInfo,
              // )),
              child: Container(
                height: SizeConfig.heightMultiplier * 10,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      width: SizeConfig.heightMultiplier * 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: GestureDetector(
                          onTap: () => Get.to(
                            () => FullImagePreview(
                                imageUrl: NETWORK_IMAGE_URL +
                                    postmodel.userInfo.userAvatar,
                                blurHash: postmodel.userInfo.blurHash),
                          ),
                          child: postmodel.userInfo.userAvatar == null
                              ? Image.asset('assets/default.jpeg')
                              : BlurHash(
                                  hash: postmodel.userInfo.blurHash,
                                  image: NETWORK_IMAGE_URL +
                                      postmodel.userInfo.userAvatar,
                                ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postmodel.userInfo.userName,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 0.5,
                        ),
                        Text(
                          '${readTimestamp(postmodel.createdOn.millisecondsSinceEpoch)}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      child: GetBuilder<PlayAudioController>(
                          init: PlayAudioController(),
                          builder: (controller) {
                            return IconButton(
                              onPressed: () => controller.playAudio(postmodel),
                              icon: Icon(
                                Icons.play_arrow,
                                color: PINK_COLOR,
                                size: 28,
                              ),
                            );
                          }),
                      margin: EdgeInsets.only(right: Get.width * 0.05),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Text(
                    postmodel.title,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
            Container(
              height: SizeConfig.heightMultiplier * 28,
              margin: EdgeInsets.only(top: 8),
              child: Carousel(
                items: postmodel.imageList,
                blurHash: postmodel.blurHash,
                builderFunction: (context, item, blurHash) {
                  return ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: SizedBox(
                      width: SizeConfig.widthMultiplier * 75,
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => FullImagePreview(
                              imageUrl: NETWORK_IMAGE_URL + item,
                              blurHash: blurHash),
                        ),
                        child: BlurHash(
                          color: Colors.black,
                          hash: blurHash,
                          image: NETWORK_IMAGE_URL + item,
                          imageFit: BoxFit.fitHeight,
                          decodingHeight:
                              (SizeConfig.heightMultiplier * 28).round(),
                          decodingWidth:
                              (SizeConfig.widthMultiplier * 75).round(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            BottomFuntionality(
              postmodel: postmodel,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8, left: 12, bottom: 0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: postmodel.userInfo.userName + '\t',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: postmodel.description,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Container(height: 200,width: 100,color: ,)
          ],
        ));

    // bottomNavigationBar: GetBuilder<PlayAudioController>(
    //     init: PlayAudioController(),
    //     builder: (controller) {
    //       return controller.buildBottomBar(context, postmodel);
    //     }),
  }

  Future<ui.Image> _getImage() {
    Image image = new Image.network(NETWORK_IMAGE_URL + postmodel.imageList[0]);
    Completer<ui.Image> completer = new Completer<ui.Image>();
    image.image
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));
    return completer.future;
  }

  String readTimestamp(int timestamp) {
    final f = new DateFormat('MMM. dd, yyyy hh:mm a');
    return f.format(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }
}
