import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/view/screens/search/components/list_images_post.dart';
import 'package:epics/view/screens/search/components/single_post_image.dart';
import 'package:epics/view/screens/search/search_page.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'components/user_Info_part.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PostController>(
          init: PostController(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () => controller.getData(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        UserInfoPart(),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: GetX<PostController>(
                        init: PostController(),
                        builder: (controller) {
                          if (controller.myPostsList.length != 0) {
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
                                  PostsModel postmodel =
                                      controller.myPostsList[index];
                                  if (postmodel.imageList.length != 1) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: SlideAnimation(
                                        verticalOffset: 80,
                                        child: FadeInAnimation(
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
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
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: SlideAnimation(
                                        verticalOffset: 80,
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            onTap: () =>
                                                Get.to(() => SingleImagePost(
                                                      postmodel: postmodel,
                                                      index: index,
                                                    )),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              child: BlurHash(
                                                image: NETWORK_IMAGE_URL +
                                                    postmodel.imageList[0],
                                                hash: postmodel.blurHash[0],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                childCount: controller.myPostsList.length,
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
                                      Text('Profile',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                      SizedBox(height: Get.height * 0.01),
                                      Text(
                                        'All your shared and saved \n photos will appear here',
                                        textAlign: TextAlign.center,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
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
