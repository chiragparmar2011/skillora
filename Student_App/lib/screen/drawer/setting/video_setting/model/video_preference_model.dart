class VideoPreferenceModel {
  VideoPreferenceModel({
    this.id,
    this.userId,
    this.downloadWifi,
    this.beforeDownloadResourse,
    this.autoplayNextLecture,
    this.playBackground,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  VideoPreferenceModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    downloadWifi = json['download_wifi'];
    beforeDownloadResourse = json['before_download_resourse'];
    autoplayNextLecture = json['autoplay_next_lecture'];
    playBackground = json['play_background'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  String? downloadWifi;
  String? beforeDownloadResourse;
  String? autoplayNextLecture;
  String? playBackground;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['download_wifi'] = downloadWifi;
    map['before_download_resourse'] = beforeDownloadResourse;
    map['autoplay_next_lecture'] = autoplayNextLecture;
    map['play_background'] = playBackground;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
