import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/model/models/like_model.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/services/post_service.dart';
import 'package:epics/view/screens/homepage/pages/comment_page.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'list_tile.dart';

class BottomFuntionality extends StatefulWidget {
  const BottomFuntionality({
    Key key,
    this.postmodel,
  }) : super(key: key);

  final PostsModel postmodel;

  @override
  _BottomFuntionalityState createState() => _BottomFuntionalityState();
}

class _BottomFuntionalityState extends State<BottomFuntionality> {
  @override
  Widget build(BuildContext context) {
    List likedList = widget.postmodel.likesList;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      // color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            width: SizeConfig.widthMultiplier * 22,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (likedList.contains(
                            Get.find<AuthController>().userUid.value)) {
                          widget.postmodel.likesList
                              .remove(Get.find<AuthController>().userUid.value);
                          PostService().deleteLike(
                              widget.postmodel.postId,
                              widget.postmodel.likesList,
                              Get.find<AuthController>().userUid.value);
                          setState(() {});
                        } else {
                          widget.postmodel.likesList
                              .add(Get.find<AuthController>().userUid.value);
                          PostService().insertLike(
                              widget.postmodel.userId,
                              widget.postmodel.postId,
                              widget.postmodel.likesList,
                              Get.find<AuthController>().userUid.value);
                          setState(() {});
                        }
                      },
                      child: SvgPicture.asset(
                        likedList.contains(
                                Get.find<AuthController>().userUid.value)
                            ? 'assets/icons/colored heart.svg'
                            : 'assets/icons/001-heart.svg',
                        color: likedList.contains(
                                Get.find<AuthController>().userUid.value)
                            ? Colors.red
                            : Colors.black,
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                    ),
                    SizedBox(width: SizeConfig.widthMultiplier * 2),
                    GestureDetector(
                        onTap: () => _buildLikesModelSheet(
                            context, widget.postmodel.postId),
                        child: Text(widget.postmodel.likesList != null
                            ? widget.postmodel.likesList.length.toString()
                            : '0')),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.to(
                      () => CommentPage(postModel: widget.postmodel),
                      transition: Transition.rightToLeftWithFade),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/comment.svg',
                        height: SizeConfig.heightMultiplier * 2.9,
                      ),
                      SizedBox(width: SizeConfig.widthMultiplier * 2),
                      Text(''),
                    ],
                  ),
                ),
                // SvgPicture.asset(
                //   'assets/icons/share.svg',
                //   height: SizeConfig.heightMultiplier * 2.9,
                //   color: Colors.black,
                // ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 12.0),
          //   child: SvgPicture.asset(
          //     'assets/icons/bookmark.svg'
          //     // : 'assets/icons/save.svg'
          //     ,
          //     color: Colors.black,
          //     height: SizeConfig.heightMultiplier * 3,
          //   ),
          // )
        ],
      ),
    );
  }

  void _buildLikesModelSheet(BuildContext context, int postid) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      bounce: true,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: Get.height * 0.9,
            color: Color.fromRGBO(0, 0, 0, 0.001),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    height: SizeConfig.heightMultiplier * 0.7,
                    width: SizeConfig.widthMultiplier * 15,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: PostService().getLikesUser(postid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<LikeModel> listOfLikedModel = List.from(snapshot
                              .data.data
                              .map((e) => LikeModel.fromMap(e)));
                          if (listOfLikedModel.length != 0) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: listOfLikedModel.length,
                              itemBuilder: (context, index) {
                                final LikeModel likeModel =
                                    listOfLikedModel[index];
                                return LikeTile(likeModel: likeModel);
                              },
                            );
                          } else {
                            return Center(
                              child: Text('No one liked yet'),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
