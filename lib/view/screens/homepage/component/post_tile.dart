import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/view/screens/homepage/component/imageList_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'single_image_post.dart';

class PostList extends StatelessWidget {
  PostList({
    Key key,
  }) : super(key: key);
  final postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: GetX<PostController>(
            init: PostController(),
            builder: (ctx) {
              if (ctx.loading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (postController.homePageList.length != 0) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: postController.homePageList.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      PostsModel postmodel = postController.homePageList[index];

                      if (postmodel.imageList.length == 1) {
                        return PostOfSingleImage(postmodel: postmodel);
                      } else {
                        return ListImagesPost(postmodel: postmodel);
                      }
                    });
              } else {
                // print(ctx.loading.value);

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('See new posts',
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Follow other so you can see their post ',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
