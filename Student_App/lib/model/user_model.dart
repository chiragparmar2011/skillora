import 'package:skillora/screen/drawer/setting/model/setting_model.dart';
import 'package:skillora/screen/drawer/setting/video_setting/model/video_preference_model.dart';
import 'package:skillora/services/response_model.dart';

class UserModel extends ResponseDataObjectSerialization<UserModel> {
  String? firstName;
  String? lastName;
  dynamic address;
  String? email;
  String? image;
  String? phone;
  dynamic socialId;
  dynamic emailVerifiedAt;
  String? status;
  String? token;
  String? createdAt;
  String? updatedAt;
  VideoPreferenceModel? videoPreferenceModel;
  SettingModel? settingModel;

  UserModel({
    this.firstName,
    this.lastName,
    this.address,
    this.email,
    this.image,
    this.phone,
    this.socialId,
    this.emailVerifiedAt,
    this.status,
    this.token,
    this.videoPreferenceModel,
    this.settingModel,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json['first_name'],
        lastName: json['last_name'],
        address: json['address'],
        email: json['email'],
        image: json['image'],
        phone: json['phone'],
        socialId: json['social_id'],
        emailVerifiedAt: json['email_verified_at'],
        status: json['status'],
        token: json['token'],
        videoPreferenceModel: json['videopreference'] == null
            ? null
            : VideoPreferenceModel.fromJson(json['videopreference']),
        settingModel: json['setting'] == null
            ? null
            : SettingModel.fromJson(json['setting']),
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['address'] = address;
    map['email'] = email;
    map['image'] = image;
    map['phone'] = phone;
    map['social_id'] = socialId;
    map['email_verified_at'] = emailVerifiedAt;
    map['status'] = status;
    map['token'] = token;
    map['setting'] = settingModel;
    map['videopreference'] = videoPreferenceModel;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  String get fullName {
    if (firstName == null) {
      return 'Demo User';
    }

    return '${firstName ?? ''} ${lastName ?? ''}';
  }
}
