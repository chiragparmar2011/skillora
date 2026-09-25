class QuestionItemModel {
  int id;
  int courseId;
  String courseName;
  int? lessonId;
  String? lessonName;
  String studentName;
  String? studentAvatar;
  String title;
  String description;
  String createdAt;
  bool isAnswered;
  List<AnswerItemModel> answers;

  QuestionItemModel({
    required this.id,
    required this.courseId,
    required this.courseName,
    this.lessonId,
    this.lessonName,
    required this.studentName,
    this.studentAvatar,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isAnswered = false,
    List<AnswerItemModel>? answers,
  }) : answers = answers ?? [];

  factory QuestionItemModel.fromJson(Map<String, dynamic> json) {
    return QuestionItemModel(
      id: json['id'],
      courseId: json['course_id'] ?? 1,
      courseName: json['course_name'] ?? 'General Course',
      lessonId: json['lesson_id'],
      lessonName: json['lesson_name'],
      studentName: json['student_name'] ?? 'Student',
      studentAvatar: json['student_avatar'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '2026-09-20',
      isAnswered: json['is_answered'] ?? false,
      answers: (json['answers'] as List?)
              ?.map((e) => AnswerItemModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'course_name': courseName,
      'lesson_id': lessonId,
      'lesson_name': lessonName,
      'student_name': studentName,
      'student_avatar': studentAvatar,
      'title': title,
      'description': description,
      'created_at': createdAt,
      'is_answered': isAnswered,
      'answers': answers.map((e) => e.toJson()).toList(),
    };
  }
}

class AnswerItemModel {
  int id;
  String userName;
  String? userAvatar;
  bool isInstructor;
  String answer;
  String createdAt;

  AnswerItemModel({
    required this.id,
    required this.userName,
    this.userAvatar,
    this.isInstructor = false,
    required this.answer,
    required this.createdAt,
  });

  factory AnswerItemModel.fromJson(Map<String, dynamic> json) {
    return AnswerItemModel(
      id: json['id'],
      userName: json['user_name'] ?? 'User',
      userAvatar: json['user_avatar'],
      isInstructor: json['is_instructor'] ?? false,
      answer: json['answer'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'user_avatar': userAvatar,
      'is_instructor': isInstructor,
      'answer': answer,
      'created_at': createdAt,
    };
  }
}
