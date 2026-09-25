import 'package:skillora/services/response_model.dart';

class RecentSearchModel
    extends ResponseDataObjectSerialization<RecentSearchModel> {
  RecentSearchModel({
    this.id,
    this.userId,
    this.text,
    this.createdAt,
    this.updatedAt,
  });

  RecentSearchModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  String? text;
  String? createdAt;
  String? updatedAt;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['text'] = text;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

  @override
  RecentSearchModel fromJson(Map<String, dynamic> json) {
    return RecentSearchModel.fromJson(json);
  }
}
