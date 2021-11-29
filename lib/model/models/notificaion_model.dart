import 'package:epics/model/models/post_model.dart';
import 'package:epics/model/models/userinfo.dart';

class NotificationModel {
  NotificationModel({
    this.notificaationId,
    this.userfrom,
    this.userto,
    this.postId,
    this.notificationType,
    this.createdOn,
    this.userInfo,
    this.viewed,
    this.posts,
  });

  String notificaationId;
  String userfrom;
  String userto;
  int postId;
  String notificationType;
  DateTime createdOn;
  bool viewed;
  UserInfoModel userInfo;
  PostsModel posts;

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        notificaationId:
            json["notificaation_id"] == null ? null : json["notificaation_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        viewed: json["viewed"] == null ? null : json["viewed"],
        notificationType: json["notification_type"] == null
            ? null
            : json["notification_type"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        userInfo: json["user_from"] == null
            ? null
            : UserInfoModel.fromMap(json["user_from"]),
        posts: json["posts"] == null ? null : PostsModel.fromMap(json["posts"]),
      );

  Map<String, dynamic> toMap() => {
        "user_from": userfrom == null ? null : userfrom,
        "user_to": userto == null ? null : userto,
        "post_id": postId == null ? null : postId,
        "viewed": viewed == null ? null : viewed,
        "notification_type": notificationType == null ? null : notificationType,
        "created_on": createdOn == null ? null : createdOn.toIso8601String(),
      };
}
