import 'package:flutter/material.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';
import 'package:skillora/widgets/va_image_asset.dart';

class VADashboardCourse extends StatelessWidget {
  final CourseModel? courseModel;

  const VADashboardCourse({this.courseModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.bottomIconColor.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 5,
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadowColor: AppColors.darkGray,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 2),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: _buildLeadingView(),
              ),
              const SizedBox(height: 11),
              Expanded(
                flex: 3,
                child: _buildMiddleView(),
              )
            ],
          ),
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
        width: double.infinity,
        height: 94,
      ),
    );
  }

  Widget _buildMiddleView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          courseModel?.name ?? '',
          overflow: TextOverflow.ellipsis,
          style: TextStyles().textStyleRoboto(
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "by ${courseModel?.instructor?.firstName} ${courseModel?.instructor?.lastName}",
          overflow: TextOverflow.ellipsis,
          style: TextStyles().textStyleRoboto(
            fontSize: 12,
            color: AppColors.darkGray,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 13),
        Row(
          children: [
            Container(
              height: 16,
              width: 16,
              decoration: const BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: AppColors.white,
                size: 11,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                (courseModel?.lessonsCount ?? 0).toString(),
                style: TextStyles().textStyleRoboto(
                  fontSize: 12,
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.star,
              color: AppColors.yellowColor,
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              courseModel?.rating ?? '',
              style: TextStyles().textStyleRoboto(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
