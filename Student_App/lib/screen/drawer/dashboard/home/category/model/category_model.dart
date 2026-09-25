import 'package:skillora/services/response_model.dart';

class CategoryModel extends ResponseDataObjectSerialization<CategoryModel> {
  int? id;
  String? name;
  String? logo;
  String? backgroundcolor;
  String? displayColor;

  CategoryModel({
    this.id,
    this.name,
    this.logo,
    this.backgroundcolor,
    this.displayColor,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    backgroundcolor = json['backgroundcolor'];
    displayColor = json['display_color'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> categoryModel = <String, dynamic>{};
    categoryModel['id'] = id;
    categoryModel['name'] = name;
    categoryModel['logo'] = logo;
    categoryModel['backgroundcolor'] = backgroundcolor;
    categoryModel['display_color'] = displayColor;
    return categoryModel;
  }

  @override
  CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel.fromJson(json);
  }
}
