class CourseManageModel {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPrice;
  bool isFree;
  String? level;
  String? image;
  String? status; // 'published', 'draft', 'archived'
  int studentCount;
  double rating;
  int reviewCount;
  String? createdAt;
  List<ModuleManageModel> modules;

  CourseManageModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price = 0.0,
    this.discountPrice = 0.0,
    this.isFree = false,
    this.level = 'All Levels',
    this.image,
    this.status = 'published',
    this.studentCount = 0,
    this.rating = 5.0,
    this.reviewCount = 0,
    this.createdAt,
    List<ModuleManageModel>? modules,
  }) : modules = modules ?? [];

  int get totalLessons =>
      modules.fold(0, (sum, m) => sum + m.lessons.length);

  factory CourseManageModel.fromJson(Map<String, dynamic> json) {
    return CourseManageModel(
      id: json['id'],
      title: json['title'] ?? json['name'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (json['discount_price'] as num?)?.toDouble() ?? 0.0,
      isFree: json['is_free'] ?? false,
      level: json['level'] ?? 'All Levels',
      image: json['image'],
      status: json['status'] ?? 'published',
      studentCount: json['student_count'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      reviewCount: json['review_count'] ?? 0,
      createdAt: json['created_at'],
      modules: (json['modules'] as List?)
              ?.map((e) => ModuleManageModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discount_price': discountPrice,
      'is_free': isFree,
      'level': level,
      'image': image,
      'status': status,
      'student_count': studentCount,
      'rating': rating,
      'review_count': reviewCount,
      'created_at': createdAt,
      'modules': modules.map((e) => e.toJson()).toList(),
    };
  }
}

class ModuleManageModel {
  int? id;
  String title;
  List<LessonManageModel> lessons;

  ModuleManageModel({
    this.id,
    required this.title,
    List<LessonManageModel>? lessons,
  }) : lessons = lessons ?? [];

  factory ModuleManageModel.fromJson(Map<String, dynamic> json) {
    return ModuleManageModel(
      id: json['id'],
      title: json['title'] ?? '',
      lessons: (json['lessons'] as List?)
              ?.map((e) => LessonManageModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lessons': lessons.map((e) => e.toJson()).toList(),
    };
  }
}

class LessonManageModel {
  int? id;
  String title;
  String duration;
  String videoUrl;
  bool isPreview;

  LessonManageModel({
    this.id,
    required this.title,
    this.duration = '10:00',
    this.videoUrl = '',
    this.isPreview = false,
  });

  factory LessonManageModel.fromJson(Map<String, dynamic> json) {
    return LessonManageModel(
      id: json['id'],
      title: json['title'] ?? '',
      duration: json['duration'] ?? '10:00',
      videoUrl: json['video_url'] ?? '',
      isPreview: json['is_preview'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'video_url': videoUrl,
      'is_preview': isPreview,
    };
  }
}
