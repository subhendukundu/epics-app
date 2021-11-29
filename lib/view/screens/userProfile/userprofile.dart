import 'package:epics/controller/otheruserinfo_ctrl.dart';
import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/model/models/userinfo.dart';
import 'package:epics/view/screens/search/components/list_images_post.dart';
import 'package:epics/view/screens/search/components/single_post_image.dart';
import 'package:epics/view/screens/search/search_page.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' hide AnimatedScale;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'components/userProfileInfo.dart';

class OtherUserProfile extends StatefulWidget {
  const OtherUserProfile({Key key, this.userModel}) : super(key: key);
  final UserInfoModel userModel;

  @override
  _OtherUserProfileState createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  static OtherUserInfoCtrl userDataController = Get.put(OtherUserInfoCtrl());

  @override
  void initState() {
    super.initState();
    Get.put(UserInfoController());

    userDataController.getUserData(widget.userModel.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(widget.userModel.userName),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                UserProfileInfo(userModel: widget.userModel),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: GetX<OtherUserInfoCtrl>(
                init: OtherUserInfoCtrl(),
                builder: (controller) {
                  if (controller.isPostLoading.value) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: Get.height * 0.5,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  if (controller.getUsersPost.length != 0) {
                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 0.9,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          PostsModel postmodel = controller.getUsersPost[index];
                          if (postmodel.imageList.length != 1) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 400),
                              child: SlideAnimation(
                                verticalOffset: 80,
                                child: FadeInAnimation(
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      child: ListImage(
                                        index: index,
                                        postModel: postmodel,
                                      )),
                                ),
                              ),
                            );
                          } else {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 400),
                              child: SlideAnimation(
                                verticalOffset: 80,
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () => Get.to(() => SingleImagePost(
                                          postmodel: postmodel,
                                          index: index,
                                        )),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      child: BlurHash(
                                        image: NETWORK_IMAGE_URL +
                                            postmodel.imageList[0],
                                        hash: postmodel.blurHash[0],
                                        imageFit: BoxFit.contain,
                                        decodingWidth: 210,
                                        decodingHeight: 233,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        childCount: controller.getUsersPost.length,
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: Get.height * 0.4,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No Post Available',
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(height: Get.height * 0.01),
                              Text(
                                'Shared photos \n will appear here',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}

class ListImage extends StatelessWidget {
  const ListImage({
    Key key,
    this.index,
    this.postModel,
  }) : super(key: key);
  final int index;
  final PostsModel postModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => PostofImageList(
            postmodel: postModel,
          )),
      child: Stack(
        children: [
          BlurHash(
            image: NETWORK_IMAGE_URL + postModel.imageList[0],
            hash: postModel.blurHash[0],
            imageFit: BoxFit.contain,
            decodingWidth: 210,
            decodingHeight: 233,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 22,
                child: SvgPicture.asset(
                  'assets/icons/photos.svg',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
