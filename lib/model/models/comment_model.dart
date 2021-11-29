import 'package:epics/model/models/userinfo.dart';

class CommentModel {
  CommentModel({
    this.commentId,
    this.userId,
    this.postId,
    this.comment,
    this.createdOn,
    this.userInfo,
  });

  String commentId;
  String userId;
  int postId;
  String comment;
  DateTime createdOn;
  UserInfoModel userInfo;

  factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
        commentId: json["comment_id"] == null ? null : json["comment_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        comment: json["comment"] == null ? null : json["comment"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        userInfo: json["user_info"] == null
            ? null
            : UserInfoModel.fromMap(json["user_info"]),
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId == null ? null : userId,
        "post_id": postId == null ? null : postId,
        "comment": comment == null ? null : comment,
        "created_on": createdOn == null ? null : createdOn.toIso8601String(),
      };
}
