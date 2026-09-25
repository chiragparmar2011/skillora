import 'package:flutter_test/flutter_test.dart';
import 'package:instructor_app/main.dart';
import 'package:instructor_app/model/course_manage_model.dart';
import 'package:instructor_app/model/payout_model.dart';
import 'package:instructor_app/screen/dashboard/courses/course_detail_manage_view.dart';
import 'package:instructor_app/screen/dashboard/home/recent_activity_view.dart';
import 'package:instructor_app/screen/dashboard/home/notification_view.dart';
import 'package:instructor_app/screen/dashboard/home/widget/activity_detail_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Skillora Instructor smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SkilloraInstructorApp(initialLocale: Locale('en', '')));
    expect(find.byType(SkilloraInstructorApp), findsOneWidget);
  });

  testWidgets('CourseDetailManageView renders with populated course without crashing', (WidgetTester tester) async {
    final sampleCourse = CourseManageModel(
      id: 1,
      title: "Mastering Flutter & Clean Architecture",
      description: "Complete hands-on course covering Clean Architecture in Flutter.",
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
      modules: [
        ModuleManageModel(
          id: 1,
          title: "Module 1: Foundations",
          lessons: [
            LessonManageModel(
              id: 101,
              title: "1. Clean Architecture Overview",
              duration: "14:20",
              isPreview: true,
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      GetMaterialApp(
        home: CourseDetailManageView(course: sampleCourse),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text("Mastering Flutter & Clean Architecture"), findsOneWidget);
    expect(find.text("About Course"), findsOneWidget);
    expect(find.text("Module 1: Foundations"), findsOneWidget);
  });

  testWidgets('CourseDetailManageView renders with empty modules & free course', (WidgetTester tester) async {
    final freeCourse = CourseManageModel(
      id: 2,
      title: "Free Beginner Dart Course",
      description: "Introductory course for absolute beginners.",
      category: "Development",
      price: 0.0,
      isFree: true,
      level: "Beginner",
      image: null,
      status: "draft",
      studentCount: 0,
      rating: 0.0,
      reviewCount: 0,
      modules: [],
    );

    await tester.pumpWidget(
      GetMaterialApp(
        home: CourseDetailManageView(course: freeCourse),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text("Free Beginner Dart Course"), findsOneWidget);
    expect(find.text("DRAFT"), findsOneWidget);
    expect(find.text("Free"), findsOneWidget);
    expect(find.text("No curriculum modules yet."), findsOneWidget);
  });

  testWidgets('RecentActivityView renders and filters properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: RecentActivityView(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.byType(RecentActivityView), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('NotificationView renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: NotificationView(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.byType(NotificationView), findsOneWidget);
  });

  testWidgets('ActivityDetailSheet opens and renders without crash', (WidgetTester tester) async {
    final sampleTx = PayoutTransactionModel(
      id: "TX-TEST-001",
      courseName: "Test Course",
      studentName: "John Doe",
      studentEmail: "john@example.com",
      studentAvatar: "assets/images/chat_one.png",
      amount: 49.99,
      date: "2026-09-24",
      time: "10:30 AM",
      dayGroup: "Today",
      status: "completed",
    );

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => ActivityDetailSheet.show(context, sampleTx),
              child: const Text("Open Sheet"),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text("Open Sheet"));
    await tester.pumpAndSettle();

    expect(find.text("TX-TEST-001"), findsOneWidget);
    expect(find.text("John Doe\n(john@example.com)"), findsOneWidget);
  });
}
