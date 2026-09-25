import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:instructor_app/model/user_model.dart';
import 'package:instructor_app/screen/dashboard/profile/edit_profile_view.dart';
import 'package:instructor_app/screen/dashboard/profile/profile_controller.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  test('ProfileController initializes avatar and updates details successfully', () async {
    final controller = Get.put(ProfileController());
    await controller.loadProfile();

    expect(controller.user.value, isNotNull);
    expect(controller.selectedAvatar.value, isNotEmpty);

    // Switch avatar to another preset
    controller.selectAvatarPreset('assets/images/chat_two.png');
    expect(controller.selectedAvatar.value, 'assets/images/chat_two.png');

    // Update details
    controller.firstNameCtrl.text = "Robert Updated";
    final success = await controller.updateProfileDetails();

    expect(success, isTrue);
    expect(controller.user.value?.firstName, "Robert Updated");
    expect(controller.user.value?.avatar, 'assets/images/chat_two.png');
  });

  testWidgets('EditProfileView renders avatar, change photo button, and opens picker sheet', (WidgetTester tester) async {
    final controller = Get.put(ProfileController());
    controller.user.value = UserModel(
      id: 1,
      firstName: "Robert",
      lastName: "Fox",
      avatar: "assets/images/mentor_one.png",
      email: "robert.fox@skillora.edu",
      phone: "+1 555 019 2834",
      headline: "Lead Mobile Architect",
      bio: "Passionate engineer and instructor.",
    );
    controller.initEditProfile();

    await tester.pumpWidget(
      GetMaterialApp(
        home: EditProfileView(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify avatar stack & camera icon are rendered
    expect(find.byIcon(Icons.camera_alt_rounded), findsOneWidget);
    expect(find.byType(EditProfileView), findsOneWidget);

    // Tap on the camera icon to open picker sheet
    await tester.tap(find.byIcon(Icons.camera_alt_rounded));
    await tester.pumpAndSettle();

    // Verify bottom sheet options appear
    expect(find.byIcon(Icons.photo_library_rounded), findsOneWidget);

    // Tap on an avatar preset in the bottom sheet to select it
    final presetGestures = find.byType(GestureDetector);
    expect(presetGestures, findsWidgets);
  });
}
