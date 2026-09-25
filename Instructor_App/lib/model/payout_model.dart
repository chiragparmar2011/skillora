class PayoutTransactionModel {
  String id;
  String courseName;
  String studentName;
  String studentEmail;
  String? studentAvatar;
  double amount;
  String date;
  String time;
  String dayGroup; // 'Today', 'Yesterday', 'Earlier This Week'
  String status; // 'completed', 'pending'
  String type; // 'enrollment', 'payout'
  String paymentMethod;
  double platformFee;
  double netEarnings;

  PayoutTransactionModel({
    required this.id,
    required this.courseName,
    required this.studentName,
    this.studentEmail = 'student@example.com',
    this.studentAvatar,
    required this.amount,
    required this.date,
    this.time = '10:30 AM',
    this.dayGroup = 'Today',
    this.status = 'completed',
    this.type = 'enrollment',
    this.paymentMethod = 'Credit Card (Stripe)',
    double? platformFee,
    double? netEarnings,
  })  : platformFee = platformFee ?? (amount * 0.10),
        netEarnings = netEarnings ?? (amount * 0.90);

  factory PayoutTransactionModel.fromJson(Map<String, dynamic> json) {
    double amt = (json['amount'] as num?)?.toDouble() ?? 0.0;
    return PayoutTransactionModel(
      id: json['id'] ?? 'TX-${DateTime.now().millisecondsSinceEpoch}',
      courseName: json['course_name'] ?? '',
      studentName: json['student_name'] ?? '',
      studentEmail: json['student_email'] ?? 'student@example.com',
      studentAvatar: json['student_avatar'],
      amount: amt,
      date: json['date'] ?? '',
      time: json['time'] ?? '10:30 AM',
      dayGroup: json['day_group'] ?? 'Today',
      status: json['status'] ?? 'completed',
      type: json['type'] ?? 'enrollment',
      paymentMethod: json['payment_method'] ?? 'Credit Card (Stripe)',
      platformFee: (json['platform_fee'] as num?)?.toDouble() ?? (amt * 0.10),
      netEarnings: (json['net_earnings'] as num?)?.toDouble() ?? (amt * 0.90),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_name': courseName,
      'student_name': studentName,
      'student_email': studentEmail,
      'student_avatar': studentAvatar,
      'amount': amount,
      'date': date,
      'time': time,
      'day_group': dayGroup,
      'status': status,
      'type': type,
      'payment_method': paymentMethod,
      'platform_fee': platformFee,
      'net_earnings': netEarnings,
    };
  }
}