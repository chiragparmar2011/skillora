import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/services/response_model.dart';

class InstructorModel extends ResponseDataObjectSerialization<InstructorModel> {
  int? id;
  String? firstName;
  String? lastName;
  String? designation;
  String? aboutMe;
  String? address;
  String? email;
  String? image;
  String? phone;
  String? isBest;
  String? isPopular;
  String? webLink;
  String? facebookLink;
  String? instagramLink;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? student = 0;
  int? review;
  int? courseCount = 0;
  List<CourseModel>? course;

  InstructorModel({
    this.id,
    this.firstName,
    this.lastName,
    this.designation,
    this.aboutMe,
    this.address,
    this.email,
    this.image,
    this.phone,
    this.isBest,
    this.isPopular,
    this.webLink,
    this.facebookLink,
    this.instagramLink,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.student,
    this.review,
    this.courseCount,
    this.course,
  });

  InstructorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    designation = json['designation'];
    aboutMe = json['about_me'];
    address = json['address'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    isBest = json['is_best'];
    isPopular = json['is_popular'];
    webLink = json['web_link'];
    facebookLink = json['facebook_link'];
    instagramLink = json['insta_link'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    student = json['student'];
    review = json['review'];
    courseCount = json['no_course'];
    if (json['course'] != null && json['course'] is List) {
      course = <CourseModel>[];
      json['course'].forEach((v) {
        course!.add(CourseModel.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['designation'] = designation;
    data['about_me'] = aboutMe;
    data['address'] = address;
    data['email'] = email;
    data['image'] = image;
    data['phone'] = phone;
    data['is_best'] = isBest;
    data['is_popular'] = isPopular;
    data['web_link'] = webLink;
    data['facebook_link'] = facebookLink;
    data['insta_link'] = instagramLink;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['student'] = student;
    data['review'] = review;
    data['no_course'] = courseCount;
    if (course != null) {
      data['course'] = course!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  InstructorModel fromJson(Map<String, dynamic> json) {
    return InstructorModel.fromJson(json);
  }
}
