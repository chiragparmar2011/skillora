import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/model/user_model.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';
import 'package:skillora/utilities/app_constants.dart';

class SignInController extends BaseController with ConnectivityMixin {
  RxBool isPasswordVisible = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isSocialLogin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onInitSetup() {
    _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
  }

  Future<void> loginUser({User? currentUser}) async {
    try {
      changeLoaderStatus(true);

      Map<String, dynamic> requestData = {
        'email': emailController.text,
        'device_token': SharedPreferenceHelper.getFcmToken(),
        'user_type': AppConstants.user,
      };

      if (currentUser != null) {
        List<String> name = currentUser.displayName?.split(" ") ?? [];
        String firstName = (name.length > 1) ? name[0] : "";
        String lastName = (name.length >= 2) ? name[1] : "";

        requestData.addAll({
          'is_social': '1',
          'social_id': currentUser.uid,
          'first_name': firstName,
          'last_name': lastName,
          'email': currentUser.email,
        });
      } else {
        requestData.addAll({
          'password': passwordController.text,
        });
      }

      UserModel? data = await apiServices.login(requestData);
      if (data != null) {
        SharedPreferenceHelper.setAuthToken(data.token);
        SharedPreferenceHelper.setUser(data);
        navigateToRemoveStack(RoutePath.drawer);
      }
    } catch (e) {
      showError(e.toString());
    }
    changeLoaderStatus(false);
  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _handleSignIn();
      if (googleSignInAccount == null) {
        return;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      assert(!user!.isAnonymous);
      assert(await user?.getIdToken() != null);
      final User? currentUser = _auth.currentUser;
      assert(user?.uid == currentUser?.uid);
      _handleSignOut();
      loginUser(currentUser: currentUser);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // rethrow;
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.signOut();
    _googleSignIn.disconnect();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<GoogleSignInAccount?> _handleSignIn() async =>
      await _googleSignIn.signIn();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
