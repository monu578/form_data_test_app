// To parse this JSON data, do
//
//     final imageList = imageListFromJson(jsonString);

import 'dart:convert';

ImageList imageListFromJson(String str) => ImageList.fromJson(json.decode(str));

String imageListToJson(ImageList data) => json.encode(data.toJson());

class ImageList {
  String? status;
  List<ImageData>? images;

  ImageList({
    this.status,
    this.images,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
        status: json["status"],
        images: json["images"] == null ? [] : List<ImageData>.from(json["images"]!.map((x) => ImageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class ImageData {
  String? xtImage;
  String? id;

  ImageData({
    this.xtImage,
    this.id,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        xtImage: json["xt_image"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "xt_image": xtImage,
        "id": id,
      };
}
