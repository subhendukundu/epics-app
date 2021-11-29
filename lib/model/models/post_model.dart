import 'package:epics/model/models/userinfo.dart';

class PostsModel {
  PostsModel(
      {this.postId,
      this.userId,
      this.title,
      this.description,
      this.tags,
      this.songUrl,
      this.imageList,
      this.songImage,
      this.songName,
      this.createdOn,
      this.privacy,
      this.updatedOn,
      this.accessTo,
      this.blurHash,
      this.likesList,
      this.userInfo});

  int postId;
  String userId;
  String title;
  String description;
  List<String> tags;
  List<String> blurHash;
  String songUrl;
  String songImage;
  String songName;
  List<String> imageList;
  DateTime createdOn;
  DateTime updatedOn;
  String privacy;
  UserInfoModel userInfo;
  List<String> likesList;
  List<String> accessTo;

  factory PostsModel.fromMap(Map<String, dynamic> json) => PostsModel(
        postId: json["post_id"] == null ? null : json["post_id"],
        accessTo: json["access_to"] == null
            ? null
            : List<String>.from(json["access_to"].map((x) => x)),
        userId: json["user_id"] == null ? null : json["user_id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        songName: json["song_name"] == null ? null : json["song_name"],
        songImage: json["song_image"] == null ? null : json["song_image"],
        blurHash: json["blurhash_list"] == null
            ? null
            : List<String>.from(json["blurhash_list"].map((x) => x)),
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        songUrl: json["song_url"] == null ? null : json["song_url"],
        privacy: json["privacy"] == null ? null : json["privacy"],
        imageList: json["image_list"] == null
            ? null
            : List<String>.from(json["image_list"].map((x) => x)),
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        userInfo: json["user_info"] == null
            ? null
            : UserInfoModel.fromMap(
                json["user_info"],
              ),
        likesList: json["likes_list"] == null
            ? []
            : List<String>.from(json["likes_list"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId == null ? null : userId,
        "title": title == null ? null : title,
        "song_image": songImage == null ? null : songImage,
        "song_name": songName == null ? null : songName,
        "description": description == null ? null : description,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "blurhash_list": blurHash == null
            ? null
            : List<dynamic>.from(blurHash.map((x) => x)),
        "song_url": songUrl == null ? null : songUrl,
        "privacy": privacy == null ? null : privacy,
        "access_to":
            userId == null ? null : List<dynamic>.from(accessTo.map((x) => x)),
        "likes_list": likesList == null ? [] : likesList,
        "image_list": imageList == null
            ? null
            : List<dynamic>.from(imageList.map((x) => x)),
        "created_on": createdOn == null ? null : createdOn.toIso8601String(),
        "updated_on": updatedOn == null ? null : updatedOn.toIso8601String(),
      };
}
