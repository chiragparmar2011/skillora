import 'package:skillora/services/response_model.dart';

class InstructorReplyModel {
  String? instructorName;
  String? instructorImage;
  String? replyText;
  String? createdAt;

  InstructorReplyModel({
    this.instructorName,
    this.instructorImage,
    this.replyText,
    this.createdAt,
  });

  factory InstructorReplyModel.fromJson(Map<String, dynamic> json) {
    return InstructorReplyModel(
      instructorName: json['instructor_name'],
      instructorImage: json['instructor_image'],
      replyText: json['reply_text'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instructor_name': instructorName,
      'instructor_image': instructorImage,
      'reply_text': replyText,
      'created_at': createdAt,
    };
  }
}

class ReviewModel extends ResponseDataObjectSerialization<ReviewModel> {
  int? id;
  int? courseId;
  String? userName;
  String? userImage;
  double? rating;
  String? comment;
  String? createdAt;
  InstructorReplyModel? instructorReply;

  ReviewModel({
    this.id,
    this.courseId,
    this.userName,
    this.userImage,
    this.rating,
    this.comment,
    this.createdAt,
    this.instructorReply,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    userName = json['user_name'];
    userImage = json['user_image'];
    rating = json['rating'] != null ? (json['rating'] as num).toDouble() : 5.0;
    comment = json['comment'];
    createdAt = json['created_at'];
    instructorReply = json['instructor_reply'] != null
        ? InstructorReplyModel.fromJson(json['instructor_reply'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'user_name': userName,
      'user_image': userImage,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
      'instructor_reply': instructorReply?.toJson(),
    };
  }

  @override
  ReviewModel fromJson(Map<String, dynamic> json) {
    return ReviewModel.fromJson(json);
  }
}
