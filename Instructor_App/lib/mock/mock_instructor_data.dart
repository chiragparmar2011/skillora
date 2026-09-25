import 'package:instructor_app/model/course_manage_model.dart';
import 'package:instructor_app/model/notification_item_model.dart';
import 'package:instructor_app/model/payout_model.dart';
import 'package:instructor_app/model/question_answer_model.dart';
import 'package:instructor_app/model/review_item_model.dart';
import 'package:instructor_app/model/user_model.dart';

class MockInstructorData {
  static final MockInstructorData _instance = MockInstructorData._internal();
  factory MockInstructorData() => _instance;
  MockInstructorData._internal();

  UserModel currentInstructor = UserModel(
    id: 1,
    firstName: "Robert",
    lastName: "Fox",
    email: "robert.fox@skillora.edu",
    phone: "+1 555 019 2834",
    headline: "Lead Mobile Architect & Google Developer Expert",
    bio:
        "Passionate engineer with over 10 years of experience building production mobile apps and teaching modern cross-platform development to 15,000+ students worldwide.",
    category: "Mobile Development",
    avatar: "assets/images/mentor_one.png",
    digitalSignature: "Robert Fox, GDE",
    token: "mock_instructor_token_2026",
  );

  List<CourseManageModel> courses = [
    CourseManageModel(
      id: 1,
      title: "Mastering Flutter & Clean Architecture",
      description:
          "Comprehensive deep-dive into production Flutter development, GetX reactive state management, repository patterns, offline sync, and automated testing.",
      category: "Development",
      price: 89.99,
      discountPrice: 49.99,
      isFree: false,
      level: "Intermediate",
      image: "assets/images/course_one.png",
      status: "published",
      studentCount: 540,
      rating: 4.9,
      reviewCount: 38,
      createdAt: "2026-08-15",
      modules: [
        ModuleManageModel(
          id: 1,
          title: "Module 1: Foundations & Architecture",
          lessons: [
            LessonManageModel(
              id: 101,
              title: "1. Clean Architecture Overview & Layer Separation",
              duration: "14:20",
              videoUrl: "assets/video/demo_flutter_intro.mp4",
              isPreview: true,
            ),
            LessonManageModel(
              id: 102,
              title: "2. GetX Controller Binding & Memory Lifecycle",
              duration: "18:45",
              videoUrl: "assets/video/demo_flutter_binding.mp4",
              isPreview: true,
            ),
            LessonManageModel(
              id: 103,
              title: "3. Repository Pattern & Offline SQLite Cache",
              duration: "22:10",
              videoUrl: "assets/video/demo_flutter_repo.mp4",
              isPreview: false,
            ),
          ],
        ),
        ModuleManageModel(
          id: 2,
          title: "Module 2: Real-time Features & Deployment",
          lessons: [
            LessonManageModel(
              id: 201,
              title: "4. WebSockets & Push Notifications with FCM",
              duration: "16:30",
              videoUrl: "assets/video/demo_flutter_fcm.mp4",
              isPreview: false,
            ),
            LessonManageModel(
              id: 202,
              title: "5. Production AppBundle & Fastlane CI/CD",
              duration: "25:00",
              videoUrl: "assets/video/demo_flutter_cicd.mp4",
              isPreview: false,
            ),
          ],
        ),
      ],
    ),
    CourseManageModel(
      id: 2,
      title: "UI/UX Design Systems in Figma for Developers",
      description:
          "Design scalable design tokens, components, responsive auto-layouts, and design system documentation directly synchronized to code.",
      category: "Design",
      price: 69.99,
      discountPrice: 39.99,
      isFree: false,
      level: "All Levels",
      image: "assets/images/course_two.png",
      status: "published",
      studentCount: 380,
      rating: 4.8,
      reviewCount: 24,
      createdAt: "2026-08-28",
      modules: [
        ModuleManageModel(
          id: 3,
          title: "Module 1: Design Tokens & Typography",
          lessons: [
            LessonManageModel(
              id: 301,
              title: "1. Defining Harmonious Color Scales & HSL Palettes",
              duration: "12:15",
              videoUrl: "assets/video/demo_design_tokens.mp4",
              isPreview: true,
            ),
          ],
        ),
      ],
    ),
    CourseManageModel(
      id: 3,
      title: "Node.js & Microservices Backend Engineering",
      description:
          "Build scalable backend services using NestJS, Docker, Kafka event streams, and Redis cache clusters.",
      category: "Development",
      price: 99.99,
      discountPrice: 59.99,
      isFree: false,
      level: "Advanced",
      image: "assets/images/course_three.png",
      status: "draft",
      studentCount: 0,
      rating: 0.0,
      reviewCount: 0,
      createdAt: "2026-09-10",
      modules: [],
    ),
  ];

  List<QuestionItemModel> questions = [
    QuestionItemModel(
      id: 1,
      courseId: 1,
      courseName: "Mastering Flutter & Clean Architecture",
      lessonId: 102,
      lessonName: "State Management with GetX",
      studentName: "Devon Lane",
      studentAvatar: "assets/images/chat_one.png",
      title: "How to handle reactive stream disposal during screen pop?",
      description:
          "When popping the view while a stream is actively listening, does GetX automatically cancel the subscription or should we manually close it inside onClose?",
      createdAt: "2026-09-24 10:30",
      isAnswered: false,
      answers: [],
    ),
    QuestionItemModel(
      id: 2,
      courseId: 1,
      courseName: "Mastering Flutter & Clean Architecture",
      lessonId: 103,
      lessonName: "Repository Pattern & Networking",
      studentName: "Courtney Henry",
      studentAvatar: "assets/images/chat_two.png",
      title: "Handling 401 token expiration and automatic refresh",
      description:
          "What is the best interceptor approach to catch 401 Unauthorized errors and refresh JWT tokens seamlessly before retrying the original request?",
      createdAt: "2026-09-23 11:15",
      isAnswered: true,
      answers: [
        AnswerItemModel(
          id: 1,
          userName: "Robert Fox",
          isInstructor: true,
          answer:
              "Great question Courtney! You can use an HTTP Interceptor or custom Dio/GetConnect middleware. Catch the 401 response status, pause the request queue, call your refresh endpoint, update SharedPreferences, and replay the pending request with the new Bearer token.",
          createdAt: "2026-09-23 12:05",
        ),
      ],
    ),
    QuestionItemModel(
      id: 3,
      courseId: 2,
      courseName: "UI/UX Design Systems in Figma for Developers",
      lessonId: 201,
      lessonName: "Color Palettes & Contrast Ratios",
      studentName: "Eleanor Pena",
      studentAvatar: "assets/images/chat_three.png",
      title: "Are there recommended plugins for WCAG AA compliance?",
      description:
          "Which Figma plugins do you recommend to audit color contrast ratios across dark and light modes automatically?",
      createdAt: "2026-09-22 09:40",
      isAnswered: false,
      answers: [],
    ),
  ];

  List<ReviewItemModel> reviews = [
    ReviewItemModel(
      id: 1,
      courseId: 1,
      courseName: "Mastering Flutter & Clean Architecture",
      studentName: "Bessie Cooper",
      studentAvatar: "assets/images/chat_one.png",
      rating: 5.0,
      comment:
          "The best Flutter course I have ever taken! The clean architecture explanation helped our engineering team completely refactor our production app. Highly recommended!",
      createdAt: "2026-09-23",
      instructorReply:
          "Thank you Bessie! So glad to hear it brought immediate value to your production engineering team!",
      replyCreatedAt: "2026-09-23",
    ),
    ReviewItemModel(
      id: 2,
      courseId: 1,
      courseName: "Mastering Flutter & Clean Architecture",
      studentName: "Arlene McCoy",
      studentAvatar: "assets/images/chat_two.png",
      rating: 5.0,
      comment:
          "Crystal clear explanations on GetX dependency injection and repository patterns. The video quality and code examples are top-notch.",
      createdAt: "2026-09-22",
    ),
    ReviewItemModel(
      id: 3,
      courseId: 2,
      courseName: "UI/UX Design Systems in Figma for Developers",
      studentName: "Floyd Miles",
      studentAvatar: "assets/images/chat_three.png",
      rating: 4.5,
      comment:
          "Fantastic design system curriculum. Would love to see an additional module on complex animation curves!",
      createdAt: "2026-09-20",
    ),
  ];

  List<PayoutTransactionModel> transactions = [
    PayoutTransactionModel(
      id: "TX-98412",
      courseName: "Mastering Flutter & Clean Architecture",
      studentName: "Devon Lane",
      studentEmail: "devon.lane@example.com",
      studentAvatar: "assets/images/chat_one.png",
      amount: 49.99,
      date: "2026-09-24",
      time: "10:45 AM",
      dayGroup: "Today",
      status: "completed",
      paymentMethod: "Credit Card (Stripe)",
    ),
    PayoutTransactionModel(
      id: "TX-98408",
      courseName: "UI/UX Design Systems in Figma",
      studentName: "Wade Warren",
      studentEmail: "wade.warren@example.com",
      studentAvatar: "assets/images/chat_two.png",
      amount: 39.99,
      date: "2026-09-24",
      time: "08:30 AM",
      dayGroup: "Today",
      status: "completed",
      paymentMethod: "PayPal",
    ),
    PayoutTransactionModel(
      id: "TX-98395",
      courseName: "Mastering Flutter & Clean Architecture",
      studentName: "Courtney Henry",
      studentEmail: "courtney.h@example.com",
      studentAvatar: "assets/images/chat_three.png",
      amount: 49.99,
      date: "2026-09-23",
      time: "04:15 PM",
      dayGroup: "Yesterday",
      status: "completed",
      paymentMethod: "Apple Pay",
    ),
    PayoutTransactionModel(
      id: "TX-98372",
      courseName: "Node.js & Microservices Backend",
      studentName: "Guy Hawkins",
      studentEmail: "guy.hawkins@example.com",
      studentAvatar: "assets/images/chat_one.png",
      amount: 59.99,
      date: "2026-09-23",
      time: "11:20 AM",
      dayGroup: "Yesterday",
      status: "completed",
      paymentMethod: "Credit Card (Stripe)",
    ),
    PayoutTransactionModel(
      id: "TX-98320",
      courseName: "UI/UX Design Systems in Figma",
      studentName: "Eleanor Pena",
      studentEmail: "eleanor.pena@example.com",
      studentAvatar: "assets/images/chat_two.png",
      amount: 39.99,
      date: "2026-09-21",
      time: "03:40 PM",
      dayGroup: "Earlier This Week",
      status: "completed",
      paymentMethod: "Google Pay",
    ),
    PayoutTransactionModel(
      id: "TX-98280",
      courseName: "Mastering Flutter & Clean Architecture",
      studentName: "Bessie Cooper",
      studentEmail: "bessie.c@example.com",
      studentAvatar: "assets/images/chat_one.png",
      amount: 49.99,
      date: "2026-09-20",
      time: "01:10 PM",
      dayGroup: "Earlier This Week",
      status: "completed",
      paymentMethod: "Credit Card (Stripe)",
    ),
    PayoutTransactionModel(
      id: "TX-98215",
      courseName: "Node.js & Microservices Backend",
      studentName: "Robert Fox Jr.",
      studentEmail: "rfox.student@example.com",
      studentAvatar: "assets/images/chat_three.png",
      amount: 59.99,
      date: "2026-09-19",
      time: "09:25 AM",
      dayGroup: "Earlier This Week",
      status: "completed",
      paymentMethod: "Credit Card (Stripe)",
    ),
  ];

  List<NotificationItemModel> notifications = [
    NotificationItemModel(
      id: "NOTIF-1",
      title: "New Student Question",
      message:
          "Devon Lane asked: 'How to handle reactive stream disposal during screen pop?' in Mastering Flutter.",
      time: "10:30 AM",
      dayGroup: "Today",
      type: "qa",
      targetRoute: "/qa",
      targetTabIndex: 2,
      isRead: false,
    ),
    NotificationItemModel(
      id: "NOTIF-2",
      title: "New 5-Star Review Received",
      message:
          "Bessie Cooper left a 5.0 star review: 'The clean architecture explanation helped our team refactor our production app!'",
      time: "08:15 AM",
      dayGroup: "Today",
      type: "review",
      targetRoute: "/reviews",
      targetTabIndex: 3,
      isRead: false,
    ),
    NotificationItemModel(
      id: "NOTIF-3",
      title: "Course Enrollment: +\$49.99",
      message:
          "Courtney Henry enrolled in 'Mastering Flutter & Clean Architecture'.",
      time: "04:15 PM",
      dayGroup: "Yesterday",
      type: "enrollment",
      targetRoute: "/recentActivity",
      targetTabIndex: 0,
      isRead: true,
    ),
    NotificationItemModel(
      id: "NOTIF-4",
      title: "Payout Transferred Successfully",
      message:
          "Your withdrawal request of \$1,250.00 has been sent to your primary bank account.",
      time: "01:00 PM",
      dayGroup: "Yesterday",
      type: "payout",
      targetRoute: "/earnings",
      isRead: true,
    ),
    NotificationItemModel(
      id: "NOTIF-5",
      title: "New Follower Alert",
      message:
          "Arlene McCoy and 3 other learners started following your instructor profile.",
      time: "Sep 21, 11:20 AM",
      dayGroup: "Earlier This Week",
      type: "follower",
      targetRoute: "/profile",
      targetTabIndex: 4,
      isRead: true,
    ),
    NotificationItemModel(
      id: "NOTIF-6",
      title: "Course Certificate Claimed",
      message:
          "Eleanor Pena completed 100% of UI/UX Design Systems and claimed their verified certificate with your digital signature.",
      time: "Sep 20, 02:45 PM",
      dayGroup: "Earlier This Week",
      type: "certificate",
      targetRoute: "/courseList",
      targetTabIndex: 1,
      isRead: true,
    ),
  ];
}
