import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/screen/signin/controller/signin_controller.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/utilities/assets_path.dart';
import 'package:skillora/widgets/va_button.dart';
import 'package:skillora/widgets/va_header.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';
import 'package:skillora/widgets/va_text_field.dart';

class SignInView extends GetView<SignInController> {
  SignInView({super.key});

  @override
  SignInController get controller {
    if (!Get.isRegistered<SignInController>()) {
      return Get.put(SignInController());
    }
    return Get.find<SignInController>();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Obx(
            () => controller.isInternetConnected
                ? const VANoInternetAsset()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VAHeader(
                        assetImage: AssetsPath.logoGreen,
                        firstText: translate(
                            MyGlobals.navKey.currentContext, 'login.welcome'),
                        secondText: translate(
                            MyGlobals.navKey.currentContext, 'login.signIn'),
                        heightOne: 12,
                        heightTwo: 6,
                        logoHeight: 110,
                      ),
                      _buildForm(),
                      _buildForgotPassword(),
                      _buildSignInButton(),
                      _buildContinueText(),
                      _buildSocialMedia(),
                      _buildSignUpText(),
                      _buildSkip(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      children: [
        const SizedBox(height: 18),
        VaTextField(
          controller: controller.emailController,
          headerText: translate(MyGlobals.navKey.currentContext, 'profile.email'),
          hintText: translate(MyGlobals.navKey.currentContext, 'profile.email'),
          validator: (String? value) {
            return controller.validateEmail(value ?? '');
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      children: [
        const SizedBox(height: 14),
        Obx(() {
          return VaTextField(
            controller: controller.passwordController,
            headerText:
                translate(MyGlobals.navKey.currentContext, 'profile.password'),
            obscureText: !controller.isPasswordVisible.value,
            hintText:
                translate(MyGlobals.navKey.currentContext, 'profile.password'),
            validator: (String? value) {
              if ((value ?? '').isEmpty) {
                return translate(
                    MyGlobals.navKey.currentContext, 'validation.password');
              }
              return null;
            },
            suffixIconButton: IconButton(
              icon: Icon(
                !controller.isPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.darkGray,
              ),
              onPressed: () {
                controller.togglePasswordVisibility();
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      onTap: () {
        controller.navigateTo(RoutePath.forgotPassword);
      },
      child: Column(
        children: [
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Forgot Password?',
              style: TextStyles().textStyleRoboto(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Obx(
          () => VAButton(
            backgroundColor: AppColors.primaryColor,
            isLoading: controller.isLoading.value,
            onPressed: () {
              if (controller.emailController.text.isEmpty) {
                controller.emailController.text =
                    controller.emailController.text;
              }
              if (controller.passwordController.text.isEmpty) {
                controller.passwordController.text =
                    controller.passwordController.text;
              }
              if (_formKey.currentState!.validate()) {
                controller.loginUser();
              }
            },
            text: translate(MyGlobals.navKey.currentContext, 'login.login')
                .toUpperCase(),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueText() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const Expanded(
                child: Divider(
              indent: 10,
              endIndent: 10,
              color: AppColors.secondaryColor,
            )),
            Text(
              'or continue with',
              style: TextStyles().textStyleRoboto(
                fontSize: 14,
              ),
            ),
            const Expanded(
                child: Divider(
              indent: 10,
              endIndent: 10,
              color: AppColors.secondaryColor,
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialMedia() {
    return Column(
      children: [
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () async {
            await controller.loginWithGoogle();
          },
          child: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.secondaryColor),
              color: AppColors.white,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.email_outlined,
              color: AppColors.black,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpText() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' Don’t have an account? ',
              style: TextStyles().textStyleRoboto(
                fontSize: 15,
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.navigateTo(RoutePath.signUp);
              },
              child: Text(
                'Sign Up',
                style: TextStyles().textStyleRoboto(
                  fontSize: 15,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkip() {
    return Column(
      children: [
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () {
            controller.navigateToRemoveStack(RoutePath.drawer);
          },
          child: Text(
            'Skip',
            style: TextStyles().textStyleRoboto(
              fontSize: 15,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildEmailField(),
          _buildPasswordField(),
        ],
      ),
    );
  }
}
