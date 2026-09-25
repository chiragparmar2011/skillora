class NotificationItemModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final String dayGroup; // 'Today', 'Yesterday', 'Earlier This Week'
  final String type; // 'qa', 'review', 'enrollment', 'payout', 'follower', 'certificate'
  final String targetRoute;
  final int? targetTabIndex;
  final Map<String, dynamic>? extraData;
  bool isRead;

  NotificationItemModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.dayGroup,
    required this.type,
    required this.targetRoute,
    this.targetTabIndex,
    this.extraData,
    this.isRead = false,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      time: json['time'] ?? '',
      dayGroup: json['day_group'] ?? 'Today',
      type: json['type'] ?? 'system',
      targetRoute: json['target_route'] ?? '/dashboard',
      targetTabIndex: json['target_tab_index'] as int?,
      extraData: json['extra_data'] as Map<String, dynamic>?,
      isRead: json['is_read'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'time': time,
      'day_group': dayGroup,
      'type': type,
      'target_route': targetRoute,
      'target_tab_index': targetTabIndex,
      'extra_data': extraData,
      'is_read': isRead,
    };
  }
}
