import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/services/post_service.dart';
import 'package:epics/view/screens/homepage/component/single_image_post.dart';
import 'package:epics/view/widgets/audioplay_widget.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';

class SingleImagePost extends StatelessWidget {
  const SingleImagePost({Key key, this.postmodel, this.index})
      : super(key: key);
  final PostsModel postmodel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text('Post'),
          actions: [
            if (postmodel.userInfo.userId ==
                Get.find<AuthController>().userUid.value)
              FocusedMenuHolder(
                openWithTap: true,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Icon(Icons.more_vert),
                  ),
                ),
                onPressed: () {},
                menuItems: <FocusedMenuItem>[
                  FocusedMenuItem(
                      title: Text(
                        "Delete Post",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      trailingIcon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        PostService().deleteUserPost(postmodel);
                      }),
                ],
              ),
          ]),
      body: SingleChildScrollView(
        child: PostOfSingleImage(
          postmodel: postmodel,
          index: index,
        ),
      ),
      bottomNavigationBar: Container(
        // color: Colors.red,
        height: Get.height * 0.25,
        child: PlayAudioWidget(),
      ),
    );
  }
}
