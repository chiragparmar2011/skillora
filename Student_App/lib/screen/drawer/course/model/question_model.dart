import 'package:skillora/services/response_model.dart';

class AnswerModel {
  int? id;
  String? authorName;
  String? authorImage;
  bool isInstructor;
  String? answerText;
  String? createdAt;

  AnswerModel({
    this.id,
    this.authorName,
    this.authorImage,
    this.isInstructor = false,
    this.answerText,
    this.createdAt,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'],
      authorName: json['author_name'],
      authorImage: json['author_image'],
      isInstructor: json['is_instructor'] ?? false,
      answerText: json['answer_text'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_name': authorName,
      'author_image': authorImage,
      'is_instructor': isInstructor,
      'answer_text': answerText,
      'created_at': createdAt,
    };
  }
}

class QuestionModel extends ResponseDataObjectSerialization<QuestionModel> {
  int? id;
  int? courseId;
  int? lessonId;
  String? lessonName;
  String? userName;
  String? userImage;
  String? title;
  String? description;
  String? createdAt;
  int? upvotes;
  bool? isResolved;
  List<AnswerModel>? answers;

  QuestionModel({
    this.id,
    this.courseId,
    this.lessonId,
    this.lessonName,
    this.userName,
    this.userImage,
    this.title,
    this.description,
    this.createdAt,
    this.upvotes = 0,
    this.isResolved = false,
    this.answers,
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    lessonId = json['lesson_id'];
    lessonName = json['lesson_name'];
    userName = json['user_name'];
    userImage = json['user_image'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    upvotes = json['upvotes'] ?? 0;
    isResolved = json['is_resolved'] ?? false;
    if (json['answers'] != null && json['answers'] is List) {
      answers = (json['answers'] as List)
          .map((a) => AnswerModel.fromJson(a as Map<String, dynamic>))
          .toList();
    } else {
      answers = [];
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'lesson_id': lessonId,
      'lesson_name': lessonName,
      'user_name': userName,
      'user_image': userImage,
      'title': title,
      'description': description,
      'created_at': createdAt,
      'upvotes': upvotes,
      'is_resolved': isResolved,
      'answers': answers?.map((a) => a.toJson()).toList(),
    };
  }

  @override
  QuestionModel fromJson(Map<String, dynamic> json) {
    return QuestionModel.fromJson(json);
  }
}
