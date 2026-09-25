class SettingModel {
  SettingModel({
    this.id,
    this.userId,
    this.notification,
    this.createdAt,
    this.updatedAt,
  });

  SettingModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    notification = json['notification'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  String? notification;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['notification'] = notification;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
