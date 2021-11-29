import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/model/models/like_model.dart';
import 'package:epics/view/screens/profile/user_profile.dart';
import 'package:epics/view/screens/userProfile/components/userProfileInfo.dart';
import 'package:epics/view/screens/userProfile/userprofile.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';

class LikeTile extends StatelessWidget {
  const LikeTile({
    this.likeModel,
    Key key,
  }) : super(key: key);
  final LikeModel likeModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).primaryColor,
        elevation: 2,
        child: GestureDetector(
          onTap: () => likeModel.userInfo.userId !=
                  Get.find<AuthController>().userUid.value
              ? Get.to(() => OtherUserProfile(
                    userModel: likeModel.userInfo,
                  ))
              : Get.to(() => UserProfile()),
          child: Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: likeModel.userInfo.userAvatar != null
                              ? BlurHash(
                                  hash: likeModel.userInfo.blurHash,
                                  image: NETWORK_IMAGE_URL +
                                      likeModel.userInfo.userAvatar,
                                )
                              : Image.asset('assets/default.jpeg')),
                    ),
                    SizedBox(width: SizeConfig.widthMultiplier * 3),
                    Text(likeModel.userInfo.userName,
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                // RawMaterialButton(
                //   onPressed: () {},
                //   highlightColor: Theme.of(context).primaryColor,
                //   child: Container(
                //     width: SizeConfig.widthMultiplier * 25,
                //     height: SizeConfig.heightMultiplier * 4,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(4.0),
                //       gradient: LinearGradient(
                //           colors: likeModel.following
                //               ? [
                //                   Theme.of(context).secondaryHeaderColor,
                //                   Theme.of(context).secondaryHeaderColor
                //                 ]
                //               : primaryGradient),
                //     ),
                //     // padding:
                //     //     EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                //     child: Center(
                //       child: Text(
                //         likeModel.following ? 'Following' : 'Follow',
                //         style: Theme.of(context).textTheme.bodyText1.copyWith(
                //               color: likeModel.following
                //                   ? Theme.of(context).accentColor
                //                   : Theme.of(context).primaryColor,
                //             ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}
