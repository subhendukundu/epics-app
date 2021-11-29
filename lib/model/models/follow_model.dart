import 'package:epics/model/models/userinfo.dart';

class FollowModel {
  FollowModel({
    this.followId,
    this.userFrom,
    this.userTo,
    this.followingBack,
    this.createdAt,
    this.updatedAt,
  });

  String followId;
  String userFrom;
  String userTo;
  String followingBack;
  DateTime createdAt;
  DateTime updatedAt;

  factory FollowModel.fromMap(Map<String, dynamic> json) => FollowModel(
        followId: json["follow_id"] == null ? null : json["follow_id"],
        userFrom: json["user_from"] == null ? null : json["user_from"],
        userTo: json["user_to"] == null ? null : json["user_to"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "user_from": userFrom == null ? null : userFrom,
        "user_to": userTo == null ? null : userTo,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
