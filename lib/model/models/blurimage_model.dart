class BlurImageModel {
  String hash;
  String filepath;

  BlurImageModel({this.hash, this.filepath});

  factory BlurImageModel.queryDocumentSnapshot(snapshot) {
    return BlurImageModel(
        hash: snapshot["hash"], filepath: snapshot["filePath"]);
  }

  Map<String, dynamic> toJson(BlurImageModel blurImage) =>
      {"hash": blurImage.hash, "filePath": blurImage.filepath};
}
