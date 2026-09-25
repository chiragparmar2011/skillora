import 'package:flutter/material.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_model.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/list_header_seeall_widget.dart';
import 'package:skillora/widgets/va_image_asset.dart';

class HomeCategoryWidget extends StatelessWidget {
  static const List<Color> _categoryDarkColors = [
    Color(0xff1E3A8A), // Dark Sapphire Blue
    Color(0xff6B21A8), // Dark Purple
    Color(0xff065F46), // Dark Emerald
    Color(0xff9F1239), // Dark Crimson
    Color(0xff92400E), // Dark Amber / Bronze
    Color(0xff3730A3), // Dark Indigo
    Color(0xff115E59), // Dark Teal
  ];

  const HomeCategoryWidget({
    required this.categoryList,
    this.title,
    required this.onSeeAllTap,
    required this.onDetailTap,
    super.key,
  });

  final Function() onSeeAllTap;
  final Function(int? id) onDetailTap;
  final String? title;
  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return (categoryList.isEmpty)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListHeaderSeeAllWidget(
                title: title ??
                    translate(MyGlobals.navKey.currentContext,
                        'drawer.homePage.categories'),
                onTap: onSeeAllTap,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1,
                  ),
                  itemCount: categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext ctx, index) {
                    final darkColor = _categoryDarkColors[index % _categoryDarkColors.length];
                    return GestureDetector(
                      onTap: () {
                        onDetailTap(categoryList[index].id);
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              VAImageAsset(
                                image: categoryList[index].logo ?? '',
                                color: darkColor,
                                height: 26,
                                width: 26,
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  categoryList[index].name ?? '',
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
          );
  }
}
