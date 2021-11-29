import 'package:epics/model/models/userinfo.dart';

class LikeModel {
  String likeId;
  int postId;
  UserInfoModel userInfo;
  LikeModel({this.likeId, this.postId, this.userInfo});

  factory LikeModel.fromMap(Map<String, dynamic> json) => LikeModel(
        likeId: json["like_id"] == null ? null : json["like_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        userInfo: json["user_info"] == null
            ? null
            : UserInfoModel.fromMap(json["user_info"]),
      );
}
