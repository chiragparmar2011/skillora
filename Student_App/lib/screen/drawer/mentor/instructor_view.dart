import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/helper/shared_preference_helper.dart';
import 'package:skillora/screen/drawer/mentor/controller/instructor_controller.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/screen/search/va_search_bar_common.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_data_widget.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class InstructorView extends StatelessWidget {
  InstructorView({super.key});

  final InstructorController controller = Get.put(InstructorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: Obx(
          () => controller.isInternetConnected
              ? const VANoInternetAsset()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppBar(),
                    _buildSearch(),
                    Expanded(
                      child: _buildInstructorView(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return VAAppBar(
      appBarTitle: translate(
          MyGlobals.navKey.currentContext, 'instructor.bestInstructor'),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 60,
        child: VASearchBarCommon(
          controller: controller.searchController,
          showFilter: false,
          onApply: () {
            controller.searchAPI();
          },
        ),
      ),
    );
  }

  Widget _buildInstructorView() {
    if (controller.isLoading.value) {
      return const VALoader();
    }
    return controller.instructorList.isEmpty
        ? Center(child: VaNoDataWidget())
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            itemCount: controller.instructorList.length,
            itemBuilder: (context, index) {
              InstructorModel data = controller.instructorList[index];
              bool isFollowed =
                  SharedPreferenceHelper.isInstructorFollowed(data.id ?? 0);
              return GestureDetector(
                onTap: () {
                  controller.openInstructorDetail(data);
                },
                child: Card(
                  elevation: 1,
                  shadowColor: AppColors.secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildCircleImageView(data),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${data.firstName}',
                                      style: TextStyles().textStyleRoboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (isFollowed)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors.primaryColor
                                              .withValues(alpha: 0.4),
                                          width: 0.8,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.check_rounded,
                                            size: 11,
                                            color: AppColors.primaryColor,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            translate(
                                                MyGlobals.navKey.currentContext,
                                                'instructor.following'),
                                            style: TextStyles()
                                                .textStyleRoboto(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${data.designation}',
                                style: TextStyles().textStyleRoboto(
                                  fontSize: 12,
                                  color: AppColors.dropShadow,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${data.student ?? 0} ${translate(MyGlobals.navKey.currentContext, 'instructor.student')}',
                                style: TextStyles().textStyleRoboto(
                                  fontSize: 12,
                                  color: AppColors.dropShadow,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${data.courseCount ?? 0} ${translate(MyGlobals.navKey.currentContext, 'course.course')}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.dropShadow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget _buildCircleImageView(InstructorModel mentorModel) {
    return Container(
      height: 71,
      width: 71,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(54),
          child: Image.network(
            '${mentorModel.image}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
