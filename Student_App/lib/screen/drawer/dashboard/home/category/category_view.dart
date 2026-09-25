import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/controller/category_controller.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_model.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_constants.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_appbar.dart';
import 'package:skillora/widgets/va_image_asset.dart';
import 'package:skillora/widgets/va_loader.dart';
import 'package:skillora/widgets/va_no_internet_asset.dart';

class CategoryView extends StatelessWidget {
  static const List<Color> _categoryDarkColors = [
    Color(0xff1E3A8A),
    Color(0xff6B21A8),
    Color(0xff065F46),
    Color(0xff9F1239),
    Color(0xff92400E),
    Color(0xff3730A3),
    Color(0xff115E59),
  ];

  CategoryView({super.key});

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Obx(
              () => Expanded(
                child: controller.isInternetConnected
                    ? const VANoInternetAsset()
                    : Center(child: _buildBody()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return VAAppBar(
      appBarTitle: translate(
          MyGlobals.navKey.currentContext, 'drawer.homePage.categories'),
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value) {
      return const VALoader();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 4,
                crossAxisSpacing: 6,
              ),
              itemCount: controller.categoryList?.length ?? 0,
              itemBuilder: (BuildContext ctx, index) {
                CategoryModel? category = controller.categoryList?[index];
                final darkColor = _categoryDarkColors[index % _categoryDarkColors.length];
                return GestureDetector(
                  onTap: () {
                    controller.navigateTo(RoutePath.categoryDetail, data: {
                      AppConstants.categoryId:
                          controller.categoryList?[index].id,
                    });
                  },
                  child: SizedBox(
                    height: 104,
                    width: 104,
                    child: Card(
                      elevation: 0,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.secondaryColor.withValues(alpha: 0.5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      shadowColor: AppColors.shadowColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          VAImageAsset(
                            image: category?.logo ?? '',
                            color: darkColor,
                            height: 26,
                            width: 26,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              category?.name ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles().textStyle14Roboto(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
