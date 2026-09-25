import 'dart:typed_data';

import 'package:skillora/services/response_model.dart';

class VideoModel extends ResponseDataObjectSerialization<VideoModel> {
  int? id;
  int? lessonId;
  String? name;
  String? video;
  Uint8List? image;
  int? isPreview;
  String? createdAt;
  String? updatedAt;

  VideoModel({
    this.id,
    this.lessonId,
    this.name,
    this.image,
    this.video,
    this.isPreview,
    this.createdAt,
    this.updatedAt,
  });

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonId = json['lesson_id'];
    name = json['name'];
    video = json['video'];
    image = json['image'];
    isPreview = json['is_preview'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['lesson_id'] = lessonId;
    map['name'] = name;
    map['video'] = video;
    map['image'] = image;
    map['is_preview'] = isPreview;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

  @override
  VideoModel fromJson(Map<String, dynamic> json) {
    return VideoModel.fromJson(json);
  }
}
