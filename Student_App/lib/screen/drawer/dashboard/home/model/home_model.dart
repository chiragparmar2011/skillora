import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_model.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/services/response_model.dart';

class HomeModel extends ResponseDataObjectSerialization<HomeModel> {
  // List<CourseModel>? categoryList;
  List<CategoryModel>? categoryList;
  List<CourseModel>? popularCourseList;
  List<CourseModel>? trendingCourseList;
  List<InstructorModel>? instructorList;

  HomeModel({
    this.categoryList,
    this.popularCourseList,
    this.trendingCourseList,
    this.instructorList,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        categoryList: (json['categories'] == null)
            ? null
            : List<CategoryModel>.from(json['categories']
                .map((data) => CategoryModel().fromJson(data))),
        popularCourseList: (json['popular_course'] == null)
            ? null
            : List<CourseModel>.from(json['popular_course']
                .map((data) => CourseModel.fromJson(data))),
        trendingCourseList: (json['trending_course'] == null)
            ? null
            : List<CourseModel>.from(json['trending_course']
                .map((data) => CourseModel.fromJson(data))),
        instructorList: (json['best_instructor'] == null)
            ? null
            : List<InstructorModel>.from(json['best_instructor']
                .map((data) => InstructorModel.fromJson(data))),
      );

  @override
  HomeModel fromJson(Map<String, dynamic> json) {
    return HomeModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categories'] = categoryList?.map((e) => e.toJson()).toList();
    map['popular_course'] = popularCourseList?.map((e) => e.toJson()).toList();
    map['trending_course'] =
        trendingCourseList?.map((e) => e.toJson()).toList();
    map['best_instructor'] = instructorList?.map((e) => e.toJson()).toList();
    return map;
  }
}
