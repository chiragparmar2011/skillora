class ReviewItemModel {
  int id;
  int courseId;
  String courseName;
  String studentName;
  String? studentAvatar;
  double rating;
  String comment;
  String createdAt;
  String? instructorReply;
  String? replyCreatedAt;

  ReviewItemModel({
    required this.id,
    required this.courseId,
    required this.courseName,
    required this.studentName,
    this.studentAvatar,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.instructorReply,
    this.replyCreatedAt,
  });

  factory ReviewItemModel.fromJson(Map<String, dynamic> json) {
    return ReviewItemModel(
      id: json['id'],
      courseId: json['course_id'] ?? 1,
      courseName: json['course_name'] ?? 'Professional Course',
      studentName: json['student_name'] ?? 'Student',
      studentAvatar: json['student_avatar'],
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '2026-09-20',
      instructorReply: json['instructor_reply'],
      replyCreatedAt: json['reply_created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'course_name': courseName,
      'student_name': studentName,
      'student_avatar': studentAvatar,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
      'instructor_reply': instructorReply,
      'reply_created_at': replyCreatedAt,
    };
  }
}
