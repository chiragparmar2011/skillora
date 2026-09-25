import 'package:flutter/material.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/utilities/app_utils.dart';
import 'package:skillora/widgets/va_image_asset.dart';

class CourseWidget extends StatelessWidget {
  final CourseModel? courseModel;
  final Function()? onTapBookmark;
  final Function()? onTapDetail;

  const CourseWidget({
    this.courseModel,
    this.onTapBookmark,
    this.onTapDetail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTapDetail,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLeadingView(),
            const SizedBox(width: 10),
            _buildMiddleView(),
            _buildTrailingView(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingView() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: VAImageAsset(
        image: courseModel?.image ?? '',
        boxFit: BoxFit.cover,
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _buildMiddleView() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 7,
              right: 6,
              top: 2,
              bottom: 3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.bookMarkTitleColor,
            ),
            child: Text(
              courseModel?.category?.name ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyles().textStyleRoboto(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            courseModel?.name ?? '',
            overflow: TextOverflow.ellipsis,
            style: TextStyles().textStyleRoboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppUtils().formatAmount(courseModel?.amount ?? '0'),
                  style: TextStyles().textStyleRoboto(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (courseModel?.isDiscountAvailable() ?? false) ...[
                  const WidgetSpan(child: SizedBox(width: 10)),
                  TextSpan(
                    text: AppUtils().formatAmount(courseModel?.discount ?? '0'),
                    style: TextStyles().textStyleRoboto(
                      color: AppColors.dropShadow,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(height: 10),
          IntrinsicHeight(
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.yellowColor,
                  size: 12,
                ),
                Text(
                  courseModel?.rating ?? '',
                  style: TextStyles().textStyleRoboto(
                    fontSize: 12,
                  ),
                ),
                const VerticalDivider(
                  color: AppColors.secondaryColor,
                  thickness: 1,
                  endIndent: 2,
                  indent: 2,
                ),
                Text(
                  '${courseModel?.student ?? 0} ${translate(MyGlobals.navKey.currentContext, "course.students")}',
                  style: TextStyles().textStyleRoboto(
                    fontSize: 12,
                    color: AppColors.mentorAbout,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailingView() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: onTapBookmark,
        child: Icon(
          (courseModel?.wishlist ?? false)
              ? Icons.bookmark_rounded
              : Icons.bookmark_border_rounded,
          color: AppColors.black,
          size: 20,
        ),
      ),
    );
  }
}
