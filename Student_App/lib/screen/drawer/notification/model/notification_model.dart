// class NotificationModel {
//   final String days;
//   final List<NotificationItemModel> notificationItem;
//
//   NotificationModel({required this.days, required this.notificationItem});
// }

import 'package:skillora/services/response_model.dart';

class NotificationModel extends ResponseDataObjectSerialization<NotificationModel> {
  int? id;
  int? userId;
  String? title;
  String? message;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  NotificationModel fromJson(Map<String, dynamic> json) {
    return NotificationModel.fromJson(json);
  }
}
