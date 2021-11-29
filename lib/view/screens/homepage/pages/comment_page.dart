import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/model/models/comment_model.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/services/post_service.dart';
import 'package:epics/view/screens/homepage/component/comment_box.dart';
import 'package:epics/view/screens/profile/user_profile.dart';
import 'package:epics/view/screens/userProfile/userprofile.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:epics/view/widgets/custom_toast.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:flutter/material.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key, this.postModel}) : super(key: key);
  final PostsModel postModel;

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: CommentBox(
        child: CommentList(postModel: widget.postModel),
        withBorder: false,
        formKey: formKey,
        commentController: commentController,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).accentColor,
        sendWidget: GestureDetector(
            onTap: () {
              if (commentController.text != '') {
                CommentModel model = CommentModel(
                  postId: widget.postModel.postId,
                  userId: Get.find<AuthController>().userUid.value,
                  comment: commentController.text,
                  createdOn: DateTime.now(),
                );
                PostService().addComment(model, widget.postModel.userId);
                Get.back();
                showMessage(
                    title: 'Comment Add', message: 'Comment Add Successfully');
                commentController.text = '';
              }
            },
            child: Icon(Icons.send_sharp, size: 32, color: PINK_COLOR)),
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  const CommentList({
    Key key,
    this.postModel,
  }) : super(key: key);
  final PostsModel postModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: PostService().getPostComments(postModel.postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<CommentModel> commentList = snapshot.data.data != null
                ? List.from(
                    snapshot.data.data.map((e) => CommentModel.fromMap(e)))
                : [];
            if (commentList.length != 0) {
              return ListView.builder(
                itemCount: commentList.length,
                itemBuilder: (_, index) {
                  final CommentModel commentModel = commentList[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                    child: ListTile(
                      onTap: () => commentModel.userInfo.userId !=
                              Get.find<AuthController>().userUid.value
                          ? Get.to(() => OtherUserProfile(
                                userModel: commentModel.userInfo,
                              ))
                          : Get.to(() => UserProfile()),
                      leading: GestureDetector(
                        onTap: () => commentModel.userInfo.userAvatar != null
                            ? Get.to(
                                () => FullImagePreview(
                                    imageUrl: NETWORK_IMAGE_URL +
                                        '${commentModel.userInfo.userAvatar}',
                                    blurHash: commentModel.userInfo.blurHash),
                              )
                            : Image.asset(
                                'assets/default.jpeg',
                                fit: BoxFit.fill,
                              ),
                        child: Container(
                          height: 40,
                          width: 40,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              child: commentModel.userInfo.userAvatar != null
                                  ? BlurHash(
                                      hash: commentModel.userInfo.blurHash,
                                      image: NETWORK_IMAGE_URL +
                                          commentModel.userInfo.userAvatar,
                                    )
                                  : Image.asset('assets/default.jpeg')),
                        ),
                      ),
                      title: Text(commentModel.userInfo.userName,
                          style: Theme.of(context).textTheme.bodyText1),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(readTimestamp(
                              commentModel.createdOn.millisecondsSinceEpoch)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(commentModel.comment),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('No Commnet Available')],
              );
            }
          }),
    );
  }

  String readTimestamp(int timestamp) {
    final f = new DateFormat('MMM. dd, yyyy hh:mm a');
    return f.format(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }
}
