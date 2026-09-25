class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? headline;
  String? bio;
  String? category;
  String? avatar;
  String? digitalSignature;
  String? token;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.headline,
    this.bio,
    this.category,
    this.avatar,
    this.digitalSignature,
    this.token,
  });

  String get fullName => '$firstName $lastName'.trim();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'] ?? json['firstName'],
      lastName: json['last_name'] ?? json['lastName'],
      email: json['email'],
      phone: json['phone'],
      headline: json['headline'],
      bio: json['bio'],
      category: json['category'],
      avatar: json['avatar'] ?? json['image'],
      digitalSignature: json['digital_signature'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'headline': headline,
      'bio': bio,
      'category': category,
      'avatar': avatar,
      'digital_signature': digitalSignature,
      'token': token,
    };
  }
}
