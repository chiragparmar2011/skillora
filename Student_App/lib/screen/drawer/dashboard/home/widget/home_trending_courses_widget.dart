import 'package:flutter/material.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/widgets/list_header_seeall_widget.dart';
import 'package:skillora/widgets/va_image_asset.dart';

class HomeTrendingCoursesWidget extends StatelessWidget {
  const HomeTrendingCoursesWidget({
    required this.courseList,
    required this.onSeeAllTap,
    required this.onDetailTap,
    super.key,
  });

  final Function() onSeeAllTap;
  final Function(CourseModel? data) onDetailTap;
  final List<CourseModel> courseList;

  @override
  Widget build(BuildContext context) {
    return (courseList.isEmpty)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListHeaderSeeAllWidget(
                title: translate(
                    MyGlobals.navKey.currentContext, 'course.trendingCourse'),
                onTap: onSeeAllTap,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 70.0,
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 10,
                  ),
                  itemCount: courseList.length > 10 ? 10 : courseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        onDetailTap(courseList[index]);
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(46),
                            child: VAImageAsset(
                              image: courseList[index].image ?? '',
                              boxFit: BoxFit.cover,
                            ),
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
