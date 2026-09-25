import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/subcategory_model.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/services/response_model.dart';

class CategoryDetailModel extends ResponseDataObjectSerialization<CategoryDetailModel> {
  List<CourseModel>? popularCourse;
  List<SubCategoryModel>? subcategory;
  List<PopularTopics>? popularTopics;
  List<InstructorModel>? popularInstructor;

  CategoryDetailModel({
    this.subcategory,
    this.popularCourse,
    this.popularTopics,
    this.popularInstructor,
  });

  CategoryDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['popular_course'] != null) {
      popularCourse = <CourseModel>[];
      json['popular_course'].forEach((v) {
        popularCourse!.add(CourseModel.fromJson(v));
      });
    }
    if (json['subcategory'] != null) {
      subcategory = <SubCategoryModel>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(SubCategoryModel.fromJson(v));
      });
    }
    if (json['popular_topics'] != null) {
      popularTopics = <PopularTopics>[];
      json['popular_topics'].forEach((v) {
        popularTopics!.add(PopularTopics.fromJson(v));
      });
    }
    if (json['popular_instructor'] != null) {
      popularInstructor = <InstructorModel>[];
      json['popular_instructor'].forEach((v) {
        popularInstructor!.add(InstructorModel.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (popularCourse != null) {
      data['popular_course'] = popularCourse!.map((v) => v.toJson()).toList();
    }
    if (subcategory != null) {
      data['subcategory'] = subcategory!.map((v) => v.toJson()).toList();
    }
    if (popularTopics != null) {
      data['popular_topics'] = popularTopics!.map((v) => v.toJson()).toList();
    }
    if (popularInstructor != null) {
      data['popular_instructor'] =
          popularInstructor!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  CategoryDetailModel fromJson(Map<String, dynamic> json) {
    return CategoryDetailModel.fromJson(json);
  }
}

class PopularTopics {
  int? id;
  int? courseId;
  String? topicName;
  String? isPopular;

  PopularTopics({this.id, this.courseId, this.topicName, this.isPopular});

  PopularTopics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    topicName = json['topic_name'];
    isPopular = json['is_popular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['topic_name'] = topicName;
    data['is_popular'] = isPopular;
    return data;
  }
}
