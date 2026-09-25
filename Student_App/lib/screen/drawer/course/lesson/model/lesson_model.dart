import 'package:skillora/services/response_model.dart';

class LessonsModel extends ResponseDataObjectSerialization<LessonsModel> {
  int? id;
  String? name;
  String? courseId;
  String? video;
  String? isPreview;
  String? status;
  int? lessonsVideoCount;
  String? createdAt;
  String? updatedAt;

  LessonsModel({
    this.id,
    this.name,
    this.courseId,
    this.video,
    this.isPreview,
    this.status,
    this.lessonsVideoCount,
    this.createdAt,
    this.updatedAt,
  });

  LessonsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseId = json['course_id'];
    video = json['video'];
    isPreview = json['is_preview'];
    status = json['status'];
    lessonsVideoCount = json['lessons_video_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['course_id'] = courseId;
    data['video'] = video;
    data['is_preview'] = isPreview;
    data['status'] = status;
    data['lessons_video_count'] = lessonsVideoCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  LessonsModel fromJson(Map<String, dynamic> json) {
    return LessonsModel.fromJson(json);
  }
}
