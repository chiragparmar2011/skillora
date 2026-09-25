import 'package:get/get.dart';
import 'package:skillora/services/response_model.dart';

class SubCategoryModel
    extends ResponseDataObjectSerialization<SubCategoryModel> {
  int? id;
  String? name;
  int? categoryId;
  String? status;
  String? createdAt;
  String? updatedAt;
  RxBool? isSelected = false.obs;

  SubCategoryModel({
    this.id,
    this.name,
    this.categoryId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  SubCategoryModel fromJson(Map<String, dynamic> json) {
    return SubCategoryModel.fromJson(json);
  }
}
