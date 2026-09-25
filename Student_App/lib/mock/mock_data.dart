import 'package:skillora/model/user_model.dart';
import 'package:skillora/screen/drawer/course/lesson/model/lesson_model.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/screen/drawer/course/model/question_model.dart';
import 'package:skillora/screen/drawer/course/model/review_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/subcategory_model.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/screen/drawer/notification/model/notification_model.dart';
import 'package:skillora/screen/drawer/setting/model/setting_model.dart';
import 'package:skillora/screen/drawer/setting/video_setting/model/video_preference_model.dart';
import 'package:skillora/screen/search/model/recent_search_model.dart';

class MockData {
  static final MockData _instance = MockData._internal();
  factory MockData() => _instance;
  MockData._internal() {
    _initMockData();
  }

  late UserModel currentUser;
  late List<CategoryModel> categories;
  late List<SubCategoryModel> subcategories;
  late List<CourseModel> courses;
  late List<InstructorModel> instructors;
  late Map<String, List<NotificationModel>> notifications;
  late List<RecentSearchModel> recentSearches;
  late List<ReviewModel> reviews;
  late List<QuestionModel> questions;

  void _initMockData() {
    // 1. Current User Setup
    currentUser = UserModel(
      firstName: 'Alex',
      lastName: 'Morgan',
      email: 'alex.morgan@virtualacademy.com',
      phone: '+1 234 567 8900',
      image: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&q=80',
      status: 'active',
      token: 'mock_bearer_token_123456789',
      createdAt: '2024-01-15',
      updatedAt: '2024-09-17',
      videoPreferenceModel: VideoPreferenceModel(
        id: 1,
        userId: 1,
        downloadWifi: '1',
        autoplayNextLecture: '1',
        playBackground: '1',
      ),
      settingModel: SettingModel(
        id: 1,
        userId: 1,
        notification: '1',
      ),
    );

    // 2. Categories Setup
    categories = [
      CategoryModel(
        id: 1,
        name: 'UI/UX Design',
        logo: 'https://cdn-icons-png.flaticon.com/512/1006/1006776.png',
        backgroundcolor: '#E8F0FE',
        displayColor: '#1A73E8',
      ),
      CategoryModel(
        id: 2,
        name: 'Mobile Development',
        logo: 'https://cdn-icons-png.flaticon.com/512/1006/1006774.png',
        backgroundcolor: '#FEF7E0',
        displayColor: '#F9AB00',
      ),
      CategoryModel(
        id: 3,
        name: 'Web Development',
        logo: 'https://cdn-icons-png.flaticon.com/512/1006/1006771.png',
        backgroundcolor: '#E6F4EA',
        displayColor: '#1E8E3E',
      ),
      CategoryModel(
        id: 4,
        name: 'Data Science & AI',
        logo: 'https://cdn-icons-png.flaticon.com/512/1006/1006786.png',
        backgroundcolor: '#FCE8E6',
        displayColor: '#D93025',
      ),
      CategoryModel(
        id: 5,
        name: 'Business & Marketing',
        logo: 'https://cdn-icons-png.flaticon.com/512/1006/1006778.png',
        backgroundcolor: '#F3E8FD',
        displayColor: '#9334E6',
      ),
    ];

    // 3. Subcategories Setup
    subcategories = [
      SubCategoryModel(id: 101, categoryId: 1, name: 'Figma Prototyping'),
      SubCategoryModel(id: 102, categoryId: 1, name: 'User Research'),
      SubCategoryModel(id: 201, categoryId: 2, name: 'Flutter & Dart'),
      SubCategoryModel(id: 202, categoryId: 2, name: 'iOS Swift'),
      SubCategoryModel(id: 301, categoryId: 3, name: 'React & Next.js'),
      SubCategoryModel(id: 401, categoryId: 4, name: 'Machine Learning'),
    ];

    // 4. Instructors Setup
    instructors = [
      InstructorModel(
        id: 1,
        firstName: 'Sarah',
        lastName: 'Jenkins',
        image: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=500&q=80',
        designation: 'Senior Lead UI/UX Designer at TechCorp',
        aboutMe: '10+ years of industry experience teaching user-centered design and mobile prototyping.',
        student: 14500,
        courseCount: 8,
        facebookLink: 'https://facebook.com',
        webLink: 'https://sarahdesign.com',
        instagramLink: 'https://instagram.com',
      ),
      InstructorModel(
        id: 2,
        firstName: 'Michael',
        lastName: 'Chen',
        image: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=500&q=80',
        designation: 'Flutter Google Developer Expert (GDE)',
        aboutMe: 'Passionate mobile architect specialized in cross-platform Dart and Flutter applications.',
        student: 22100,
        courseCount: 12,
        facebookLink: 'https://facebook.com',
        webLink: 'https://flutterchen.dev',
        instagramLink: 'https://instagram.com',
      ),
      InstructorModel(
        id: 3,
        firstName: 'Elena',
        lastName: 'Rostova',
        image: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=500&q=80',
        designation: 'Full Stack Tech Lead & Cloud Specialist',
        aboutMe: 'Helping over 50,000 students master React, Node.js, and modern cloud deployment architectures.',
        student: 35000,
        courseCount: 15,
        facebookLink: 'https://facebook.com',
        webLink: 'https://elenacodes.io',
        instagramLink: 'https://instagram.com',
      ),
    ];

    // 5. Lessons Setup
    final course1Lessons = [
      LessonsModel(
        id: 1,
        name: 'Module 1: Design Fundamentals',
        courseId: '1',
        video: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        isPreview: '1',
        status: 'active',
        lessonsVideoCount: 2,
      ),
      LessonsModel(
        id: 2,
        name: 'Module 2: Interactive Prototyping',
        courseId: '1',
        video: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        isPreview: '0',
        status: 'active',
        lessonsVideoCount: 3,
      ),
      LessonsModel(
        id: 6,
        name: 'Module 3: Design Systems & Developer Handoff',
        courseId: '1',
        video: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        isPreview: '0',
        status: 'active',
        lessonsVideoCount: 3,
      ),
    ];

    final course2Lessons = [
      LessonsModel(
        id: 3,
        name: 'Module 1: Flutter Setup & GetX Architecture',
        courseId: '2',
        video: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        isPreview: '1',
        status: 'active',
        lessonsVideoCount: 4,
      ),
      LessonsModel(
        id: 4,
        name: 'Module 2: REST APIs & State Management',
        courseId: '2',
        video: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        isPreview: '0',
        status: 'active',
        lessonsVideoCount: 5,
      ),
      LessonsModel(
        id: 5,
        name: 'Module 3: Stripe Checkout & App Deployment',
        courseId: '2',
        video: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        isPreview: '0',
        status: 'active',
        lessonsVideoCount: 5,
      ),
    ];

    // 6. Courses Setup
    courses = [
      CourseModel(
        id: 1,
        instructorId: 1,
        categoryId: '1',
        subcategoryId: 101,
        name: 'Complete Figma & UI/UX Masterclass 2026',
        duration: '12.5 Hours',
        amount: '89.99',
        discount: '20',
        description: 'Master modern UI design, design systems, interactive Figma components, auto-layout, and seamless handoff to developers.',
        image: 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=800&q=80',
        isPopular: '1',
        isTrending: '1',
        status: 'active',
        createdAt: '2024-02-01',
        updatedAt: '2024-09-01',
        wishlist: true,
        isPurchase: false,
        rating: '4.9',
        student: 3420,
        lessonsCount: 8,
        category: categories[0],
        subCategory: subcategories[0],
        instructor: instructors[0],
        lessonList: course1Lessons,
      ),
      CourseModel(
        id: 2,
        instructorId: 2,
        categoryId: '2',
        subcategoryId: 201,
        name: 'Flutter & Dart - Complete Production App Guide',
        duration: '28.0 Hours',
        amount: '119.99',
        discount: '30',
        description: 'Build enterprise-grade cross-platform apps using Flutter, GetX state management, REST APIs, and Stripe payment integration.',
        image: 'https://images.unsplash.com/photo-1551650975-87deedd944c3?w=800&q=80',
        isPopular: '1',
        isTrending: '1',
        status: 'active',
        createdAt: '2024-03-10',
        updatedAt: '2024-09-10',
        wishlist: false,
        isPurchase: true,
        rating: '4.8',
        student: 8900,
        lessonsCount: 14,
        category: categories[1],
        subCategory: subcategories[2],
        instructor: instructors[1],
        lessonList: course2Lessons,
      ),
      CourseModel(
        id: 3,
        instructorId: 3,
        categoryId: '3',
        subcategoryId: 301,
        name: 'Modern Web Development with Next.js & React',
        duration: '19.5 Hours',
        amount: '94.99',
        discount: '15',
        description: 'Learn server-side rendering, API routes, Tailwind CSS styling, and deployment on Vercel.',
        image: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800&q=80',
        isPopular: '0',
        isTrending: '1',
        status: 'active',
        createdAt: '2024-04-15',
        updatedAt: '2024-09-12',
        wishlist: true,
        isPurchase: false,
        rating: '4.9',
        student: 5120,
        lessonsCount: 10,
        category: categories[2],
        subCategory: subcategories[4],
        instructor: instructors[2],
        lessonList: course1Lessons,
      ),
      CourseModel(
        id: 4,
        instructorId: 2,
        categoryId: '4',
        subcategoryId: 401,
        name: 'Machine Learning & Python for Data Analytics',
        duration: '22.0 Hours',
        amount: '99.99',
        discount: '0',
        description: 'Comprehensive guide covering NumPy, Pandas, Scikit-Learn, and building predictive machine learning models.',
        image: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&q=80',
        isPopular: '1',
        isTrending: '0',
        status: 'active',
        createdAt: '2024-05-01',
        updatedAt: '2024-09-15',
        wishlist: false,
        isPurchase: false,
        rating: '4.7',
        student: 2780,
        lessonsCount: 12,
        category: categories[3],
        subCategory: subcategories[5],
        instructor: instructors[1],
        lessonList: course2Lessons,
      ),
    ];

    // 7. Notifications Setup
    notifications = {
      'Today': [
        NotificationModel(
          id: 1,
          userId: 1,
          title: 'New Course Release 🎉',
          message: 'Flutter Production App Guide has just been updated with new GetX state management lessons!',
          createdAt: '10:30 AM',
        ),
        NotificationModel(
          id: 2,
          userId: 1,
          title: 'Special Discount 🏷️',
          message: 'Get 30% off on all UI/UX Masterclass courses for the next 24 hours.',
          createdAt: '08:15 AM',
        ),
      ],
      'Yesterday': [
        NotificationModel(
          id: 3,
          userId: 1,
          title: 'Payment Confirmed 💳',
          message: 'Your enrollment in "Flutter & Dart Guide" was successful. Happy learning!',
          createdAt: 'Yesterday, 04:45 PM',
        ),
      ],
    };

    // 8. Recent Search Setup
    recentSearches = [
      RecentSearchModel(id: 1, userId: 1, text: 'Flutter GetX'),
      RecentSearchModel(id: 2, userId: 1, text: 'Figma UI/UX'),
      RecentSearchModel(id: 3, userId: 1, text: 'React Next.js'),
    ];

    // 9. Course Reviews Setup
    reviews = [
      ReviewModel(
        id: 1,
        courseId: 1,
        userName: 'John Davis',
        userImage:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150&q=80',
        rating: 5.0,
        comment:
            'Hands-down the best Flutter course available! The architecture patterns and real-world project explanations are unmatched.',
        createdAt: '2 days ago',
        instructorReply: InstructorReplyModel(
          instructorName: 'Sarah Jenkins',
          instructorImage:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500&q=80',
          replyText:
              'Thank you so much John! Keep up the great work and happy coding!',
          createdAt: '1 day ago',
        ),
      ),
      ReviewModel(
        id: 2,
        courseId: 1,
        userName: 'Emily Watson',
        userImage:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&q=80',
        rating: 5.0,
        comment:
            'Clear, concise, and straight to the point. The animations and custom painter chapters alone are worth ten times the price.',
        createdAt: '1 week ago',
      ),
      ReviewModel(
        id: 3,
        courseId: 1,
        userName: 'Carlos Gomez',
        userImage:
            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150&q=80',
        rating: 4.0,
        comment:
            'Very informative and practical! I would love an additional chapter covering automated CI/CD pipelines.',
        createdAt: '2 weeks ago',
        instructorReply: InstructorReplyModel(
          instructorName: 'Sarah Jenkins',
          instructorImage:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500&q=80',
          replyText:
              'Great suggestion Carlos! CI/CD with Fastlane and GitHub Actions will be added in our upcoming module update.',
          createdAt: '1 week ago',
        ),
      ),
      ReviewModel(
        id: 4,
        courseId: 1,
        userName: 'Priya Sharma',
        userImage:
            'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=150&q=80',
        rating: 5.0,
        comment:
            'Helped me crack my Flutter junior developer interview! The state management breakdown is gold standard.',
        createdAt: '3 weeks ago',
      ),
      ReviewModel(
        id: 5,
        courseId: 2,
        userName: 'Liam Cooper',
        userImage:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&q=80',
        rating: 5.0,
        comment:
            'Mastering Figma design systems was so easy with this course. Clean presentation and modern style!',
        createdAt: '4 days ago',
        instructorReply: InstructorReplyModel(
          instructorName: 'David Miller',
          instructorImage:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500&q=80',
          replyText:
              'Awesome job Liam! Don\'t forget to share your design portfolio in the community.',
          createdAt: '3 days ago',
        ),
      ),
      ReviewModel(
        id: 6,
        courseId: 2,
        userName: 'Sophie Chen',
        userImage:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&q=80',
        rating: 4.5,
        comment:
            'Great exercises and downloadable component libraries. Helped me redesign my company\'s design system.',
        createdAt: '2 weeks ago',
      ),
      ReviewModel(
        id: 7,
        courseId: 3,
        userName: 'Marcus Aurel',
        userImage:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&q=80',
        rating: 5.0,
        comment:
            'From zero to full-stack in weeks. The Next.js 14 App Router section is exceptional.',
        createdAt: '1 week ago',
      ),
      ReviewModel(
        id: 8,
        courseId: 4,
        userName: 'Aisha Al-Mansoor',
        userImage:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&q=80',
        rating: 5.0,
        comment:
            'Complex machine learning algorithms made simple with intuitive visualizations and code notebooks.',
        createdAt: '5 days ago',
      ),
    ];

    // 10. Course Q&A / Discussions Setup
    questions = [
      QuestionModel(
        id: 1,
        courseId: 1,
        lessonId: 2,
        lessonName: 'Lesson 2: Architecture & Clean Patterns',
        userName: 'Marcus Vance',
        userImage:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&q=80',
        title: 'How to handle session timeout and redirect to login?',
        description:
            'When using GetConnect or Dio in our repositories, what is the best practice to catch 401 Unauthorized errors globally and cleanly redirect to the SignIn screen without losing navigation stack state?',
        createdAt: '1 day ago',
        upvotes: 6,
        isResolved: true,
        answers: [
          AnswerModel(
            id: 101,
            authorName: 'Sarah Jenkins',
            authorImage:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500&q=80',
            isInstructor: true,
            answerText:
                'Hi Marcus! The recommended approach is using an interceptor on your API client. In onError, check `if (response.statusCode == 401)`, clear SharedPreferenceHelper, and call `Get.offAllNamed(RoutePath.signIn)`. We break this down in Lesson 2 at minute 14:20!',
            createdAt: '18 hours ago',
          ),
          AnswerModel(
            id: 102,
            authorName: 'Emily Watson',
            authorImage:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&q=80',
            isInstructor: false,
            answerText:
                'I also added a debounce check before triggering the redirect, which prevents duplicate snackbars when parallel requests fail simultaneously!',
            createdAt: '12 hours ago',
          ),
        ],
      ),
      QuestionModel(
        id: 2,
        courseId: 1,
        lessonId: 3,
        lessonName: 'Lesson 3: Advanced Animations',
        userName: 'David Kim',
        userImage:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&q=80',
        title: 'Android 14 predictive back gesture compatibility with video player',
        description:
            'Does PopScope handle landscape full-screen exit before popping the route on newer Android 14 devices?',
        createdAt: '3 days ago',
        upvotes: 4,
        isResolved: true,
        answers: [
          AnswerModel(
            id: 103,
            authorName: 'Sarah Jenkins',
            authorImage:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500&q=80',
            isInstructor: true,
            answerText:
                'Yes David! With `PopScope(canPop: false, onPopInvokedWithResult: ...)`, you intercept the back event, exit full screen first, and only call `Get.back()` when orientation has returned to portrait.',
            createdAt: '2 days ago',
          ),
        ],
      ),
      QuestionModel(
        id: 3,
        courseId: 2,
        lessonId: 1,
        lessonName: 'Lesson 1: Design Systems in Figma',
        userName: 'Elena Rostova',
        userImage:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&q=80',
        title: 'Component variants vs boolean properties',
        description:
            'When building our design system components, what is the best rule of thumb for using boolean component properties versus creating separate variants?',
        createdAt: '2 days ago',
        upvotes: 3,
        isResolved: true,
        answers: [
          AnswerModel(
            id: 104,
            authorName: 'David Miller',
            authorImage:
                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500&q=80',
            isInstructor: true,
            answerText:
                'Use boolean properties whenever you are toggling layer visibility on/off (like icon presence or a badge). Only use variants when size, color scheme, or layout structure changes!',
            createdAt: '1 day ago',
          ),
        ],
      ),
    ];
  }

  List<ReviewModel> getReviewsForCourse(int courseId) {
    return reviews.where((r) => r.courseId == courseId).toList();
  }

  void addReview(ReviewModel review) {
    reviews.insert(0, review);
    final courseReviews = getReviewsForCourse(review.courseId ?? 0);
    if (courseReviews.isNotEmpty) {
      final total = courseReviews.fold<double>(
          0.0, (sum, r) => sum + (r.rating ?? 5.0));
      final avg = (total / courseReviews.length).toStringAsFixed(1);
      final courseIdx = courses.indexWhere((c) => c.id == review.courseId);
      if (courseIdx != -1) {
        courses[courseIdx].ratingSet = avg;
      }
    }
  }

  List<QuestionModel> getQuestionsForCourse(int courseId) {
    return questions.where((q) => q.courseId == courseId).toList();
  }

  void addQuestion(QuestionModel question) {
    questions.insert(0, question);
  }

  void addAnswer(int questionId, AnswerModel answer) {
    final idx = questions.indexWhere((q) => q.id == questionId);
    if (idx != -1) {
      questions[idx].answers ??= [];
      questions[idx].answers!.add(answer);
    }
  }
}
