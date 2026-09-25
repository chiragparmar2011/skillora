import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/dashboard/dashboard_view.dart';
import 'package:skillora/screen/drawer/setting/profile/controller/profile_controller.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_constants.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_image_asset.dart';

class DrawerView extends StatelessWidget {
  DrawerView({super.key});

  final _advancedDrawerController = AdvancedDrawerController();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.black, AppColors.black],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          contentPadding: EdgeInsets.zero,
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _advancedDrawerController.hideDrawer();
                      },
                      child: const Icon(
                        Icons.close,
                        color: AppColors.white,
                        size: 28,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          translate(
                              MyGlobals.navKey.currentContext, 'drawer.menu'),
                          style: TextStyles().textStyleRoboto(
                            fontSize: 22,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 31),
                Container(
                  width: 70,
                  height: 70,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(54),
                      child: GetBuilder<ProfileController>(
                        init: Get.put(ProfileController()),
                        builder: (ProfileController controller) {
                          return VAImageAsset(
                            image: profileController.getProfileImage(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profileController.user.value.fullName,
                  style: TextStyles().textStyle18Roboto(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 65),
                _buildMenu(
                  title:
                      translate(MyGlobals.navKey.currentContext, 'drawer.home'),
                  icon: Icons.home_outlined,
                  onTap: () {
                    _advancedDrawerController.hideDrawer();
                  },
                ),
                _buildMenu(
                  title: translate(
                      MyGlobals.navKey.currentContext, 'course.trendingCourse'),
                  icon: Icons.trending_up_rounded,
                  onTap: () {
                    profileController.navigateTo(
                      RoutePath.trending,
                      data: {
                        AppConstants.isTrending: true,
                      },
                    );
                  },
                ),
                _buildMenu(
                  title: translate(
                      MyGlobals.navKey.currentContext, 'drawer.mentor'),
                  icon: Icons.school_outlined,
                  onTap: () {
                    profileController.navigateTo(
                      RoutePath.instructor,
                      data: {
                        AppConstants.isPopular: true,
                      },
                    );
                  },
                ),
                if (profileController.isDemoUser() == false)
                  _buildMenu(
                    title: translate(
                        MyGlobals.navKey.currentContext, 'drawer.myBookmark'),
                    icon: Icons.bookmark_outline_rounded,
                    onTap: () {
                      hideDrawer();
                      profileController.navigateTo(
                        RoutePath.bookmark,
                        data: {
                          AppConstants.isBookmark: true,
                        },
                      );
                    },
                  ),
                if (profileController.isDemoUser() == false)
                  _buildMenu(
                    title: translate(
                        MyGlobals.navKey.currentContext, 'drawer.settings'),
                    icon: Icons.settings_outlined,
                    onTap: () {
                      profileController.navigateTo(RoutePath.setting);
                    },
                  ),
                _buildMenu(
                  title: translate(
                      MyGlobals.navKey.currentContext, 'drawer.notification'),
                  icon: Icons.notifications_outlined,
                  onTap: () {
                    profileController.navigateTo(RoutePath.notification);
                  },
                ),
                _buildMenu(
                  title: translate(
                      MyGlobals.navKey.currentContext,
                      profileController.isDemoUser()
                          ? 'login.login'
                          : 'profile.logout'),
                  icon: profileController.isDemoUser()
                      ? Icons.login_rounded
                      : Icons.logout_rounded,
                  onTap: () {
                    profileController.logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 36,
          elevation: 0,
          backgroundColor: AppColors.bgColorWhite,
          leading: GestureDetector(
            onTap: () {
              _advancedDrawerController.showDrawer();
            },
            child: const Icon(
              Icons.menu_rounded,
              color: AppColors.black,
              size: 24,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(
                  RoutePath.notification,
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.notifications_outlined,
                  color: AppColors.black,
                  size: 24,
                ),
              ),
            )
          ],
        ),
        body: const DashboardView(),
      ),
    );
  }

  Widget _buildMenu(
      {required String title,
      required IconData icon,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.white,
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyles().textStyle16Roboto(color: AppColors.white),
              ),
            ],
          ),
          const SizedBox(height: 26),
        ],
      ),
    );
  }

  void hideDrawer() {
    _advancedDrawerController.hideDrawer();
  }
}
