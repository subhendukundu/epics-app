import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/view/screens/searchResult/search_reseult.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'components/list_images_post.dart';
import 'components/single_post_image.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
        init: PostController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getData(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: ListTile(
                  onTap: () => Get.to(() => SearchResult(),
                      transition: Transition.downToUp),
                  contentPadding: EdgeInsets.all(0),
                  title: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: SizeConfig.widthMultiplier * 3),
                          Text(
                            "Search",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                elevation: 0,
              ),
              body: SafeArea(
                child: Container(
                  child: CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(height: 8.0),
                          GetX<PostController>(
                              init: PostController(),
                              builder: (controller) {
                                if (controller.publicPostList.length != 0)
                                  return StaggeredGridView.countBuilder(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 2.0,
                                    crossAxisSpacing: 2.0,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: controller.publicPostList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (controller.publicPostList[index]
                                              .imageList.length !=
                                          1) {
                                        return ListImagePost(
                                          index: index,
                                          postModel:
                                              controller.publicPostList[index],
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () =>
                                              Get.to(() => SingleImagePost(
                                                    postmodel: controller
                                                        .publicPostList[index],
                                                    index: index,
                                                  )),
                                          child: BlurHash(
                                            image: NETWORK_IMAGE_URL +
                                                controller.publicPostList[index]
                                                    .imageList[0],
                                            hash: controller
                                                .publicPostList[index]
                                                .blurHash[0],
                                            imageFit: BoxFit.contain,
                                            decodingWidth: 210,
                                            decodingHeight: 210,
                                          ),
                                        );
                                      }
                                    },
                                    staggeredTileBuilder: (int index) {
                                      return new StaggeredTile.count(
                                          tileMap[index % 18],
                                          crossAxistileMap[index % 18]);
                                    },
                                  );
                                else
                                  return SizedBox(
                                    height: Get.height * 0.9,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Search',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6),
                                        SizedBox(height: Get.height * 0.01),
                                        Text(
                                          'Publically published posts\nwill be shown here',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ],
                                    ),
                                  );
                              }),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }
}

class ListImagePost extends StatelessWidget {
  const ListImagePost({
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
            decodingHeight: 210,
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

// 0 10 18 28 36 46
final Map<int, int> tileMap = {
  0: 2,
  1: 1,
  2: 1,
  3: 1,
  4: 1,
  5: 1,
  6: 1,
  7: 1,
  8: 1,
  9: 1,
  10: 2,
  11: 1,
  12: 1,
  13: 1,
  14: 1,
  15: 1,
  16: 1,
  17: 1
};
//Cross axis
final Map<int, double> crossAxistileMap = {
  0: 2.0,
  1: 1.0,
  2: 1.0,
  3: 1.0,
  4: 1.0,
  5: 1.0,
  6: 1.0,
  7: 1.0,
  8: 1.0,
  9: 1.0,
  10: 2.0,
  11: 1.0,
  12: 1.0,
  13: 1.0,
  14: 1.0,
  15: 1.0,
  16: 1.0,
  17: 1.0
};
