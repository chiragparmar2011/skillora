import 'package:skillora/screen/drawer/course/lesson/model/lesson_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/subcategory_model.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/services/response_model.dart';

class CourseModel extends ResponseDataObjectSerialization<CourseModel> {
  CourseModel({
    int? id,
    int? instructorId,
    String? categoryId,
    int? subcategoryId,
    String? name,
    String? duration,
    String? amount,
    String? discount,
    String? description,
    String? image,
    String? isPopular,
    String? isTrending,
    String? status,
    String? createdAt,
    String? updatedAt,
    bool? wishlist,
    bool? isPurchase,
    String? rating,
    int? student,
    int? lessonsCount,
    CategoryModel? category,
    SubCategoryModel? subCategory,
    InstructorModel? instructor,
    List<LessonsModel>? lessonList,
  }) {
    _id = id;
    _instructorId = instructorId;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _name = name;
    _duration = duration;
    _amount = amount;
    _discount = discount;
    _description = description;
    _image = image;
    _isPopular = isPopular;
    _isTrending = isTrending;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _wishlist = wishlist;
    _isPurchase = isPurchase;
    _rating = rating;
    _student = student;
    _lessonsCount = lessonsCount;
    _category = category;
    _subCategory = subCategory;
    _instructor = instructor;
    _lessonList = lessonList;
  }

  @override
  CourseModel fromJson(Map<String, dynamic> json) {
    return CourseModel.fromJson(json);
  }

  CourseModel.fromJson(dynamic json) {
    _id = json['id'];
    _instructorId = json['instructor_id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _name = json['name'];
    _duration = json['duration'];
    _amount = json['amount'];
    _discount = json['discount'];
    _description = json['description'];
    _image = json['image'];
    _isPopular = json['is_popular'];
    _isTrending = json['is_trending'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _wishlist = json['wishlist'];
    _isPurchase = json['is_purchase'];
    _rating = json['rating'];
    _student = json['student'];
    _lessonsCount = json['lessonsCount'];
    _category = json['category'] != null
        ? CategoryModel().fromJson(json['category'])
        : null;

    _subCategory = json['subcategory'] != null
        ? SubCategoryModel.fromJson(json['subcategory'])
        : null;

    _instructor = json['instructor'] != null
        ? InstructorModel.fromJson(json['instructor'])
        : null;

    _lessonList = (json['lessons'] == null || json['lessons'] is! List)
        ? null
        : List<LessonsModel>.from(
            (json['lessons'] as List).map(
              (data) => LessonsModel.fromJson(data),
            ),
          );
  }

  int? _id;
  int? _instructorId;
  String? _categoryId;
  int? _subcategoryId;
  String? _name;
  String? _duration;
  String? _amount;
  String? _discount;
  String? _description;
  String? _image;
  String? _isPopular;
  String? _isTrending;
  String? _status;
  bool? _wishlist;
  String? _rating;
  int? _student;
  int? _lessonsCount;
  String? _createdAt;
  String? _updatedAt;
  bool? _isPurchase;
  CategoryModel? _category;
  SubCategoryModel? _subCategory;
  InstructorModel? _instructor;
  List<LessonsModel>? _lessonList;

  int? get id => _id;

  int? get instructorId => _instructorId;

  String? get categoryId => _categoryId;

  int? get subcategoryId => _subcategoryId;

  String? get name => _name;

  String? get duration => _duration;

  String? get amount => _amount;

  String? get discount => _discount ?? '';

  bool isDiscountAvailable() {
    if (_discount == null || _discount!.isEmpty || _discount == '0') return false;
    double? disc = double.tryParse(_discount!.replaceAll(RegExp(r'[^0-9.]'), ''));
    return disc != null && disc > 0;
  }

  String? get description => _description;

  String? get image => _image;

  String? get isPopular => _isPopular;

  String? get isTrending => _isTrending;

  String? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  bool? get wishlist => _wishlist;

  bool? get purchase => _isPurchase;

  String? get rating => _rating;

  int? get student => _student;

  int? get lessonsCount => _lessonsCount;

  CategoryModel? get category => _category;

  SubCategoryModel? get subCategory => _subCategory;

  InstructorModel? get instructor => _instructor;

  List<LessonsModel>? get lessonList => _lessonList;

  set purchaseSet(bool? value) {
    _isPurchase = value;
  }

  set wishlistSet(bool? value) {
    _wishlist = value;
  }

  set ratingSet(String? value) {
    _rating = value;
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['instructor_id'] = _instructorId;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['name'] = _name;
    map['duration'] = _duration;
    map['amount'] = _amount;
    map['discount'] = _discount;
    map['description'] = _description;
    map['image'] = _image;
    map['is_popular'] = _isPopular;
    map['is_trending'] = _isTrending;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['wishlist'] = _wishlist;
    map['is_purchase'] = _isPurchase;
    map['rating'] = _rating;
    map['student'] = _student;
    map['lessonsCount'] = _lessonsCount;
    map['category'] = _category;
    map['subCategory'] = _subCategory;
    map['instructor'] = instructor;
    map['lessons'] = lessonList;
    return map;
  }
}
