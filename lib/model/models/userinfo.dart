class UserInfoModel {
  UserInfoModel({
    this.userId,
    this.phone,
    this.userName,
    this.bio,
    this.userAvatar,
    this.createdAt,
    this.updatedAt,
    this.lastSeen,
    this.isActive,
    this.blurHash,
  });

  String userId;
  String phone;
  String userName;
  String bio;
  String userAvatar;
  String blurHash;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime lastSeen;
  bool isActive;

  factory UserInfoModel.fromMap(Map<String, dynamic> json) => UserInfoModel(
        userId: json["user_id"] == null ? null : json["user_id"],
        phone: json["phone"] == null ? null : json["phone"],
        userName: json["user_name"] == null ? null : json["user_name"],
        bio: json["bio"] == null ? null : json["bio"],
        userAvatar: json["user_avatar"] == null ? null : json["user_avatar"],
        blurHash: json["user_avatar_blurhash"] == null
            ? null
            : json["user_avatar_blurhash"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        lastSeen: json["last_seen"] == null
            ? null
            : DateTime.parse(json["last_seen"]),
        isActive: json["is_active"] == null ? null : json["is_active"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId == null ? null : userId,
        "phone": phone == null ? null : phone,
        "user_name": userName == null ? null : userName,
        "bio": bio == null ? null : bio,
        "user_avatar": userAvatar == null ? null : userAvatar,
        "user_avatar_blurhash": blurHash == null ? null : blurHash,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "last_seen": lastSeen == null ? null : lastSeen.toIso8601String(),
        "is_active": isActive == null ? null : isActive,
      };
}
