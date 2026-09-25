import 'package:flutter/material.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/course/model/course_model.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/widgets/list_header_seeall_widget.dart';
import 'package:skillora/widgets/va_dashboard_course.dart';

class HomePopularCoursesWidget extends StatelessWidget {
  const HomePopularCoursesWidget({
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
                    MyGlobals.navKey.currentContext, 'course.popularCourse'),
                onTap: onSeeAllTap,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    mainAxisExtent: 190,
                    crossAxisCount: 1,
                    mainAxisSpacing: 5,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: courseList.length > 10 ? 10 : courseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        onDetailTap(courseList[index]);
                      },
                      child: VADashboardCourse(
                        courseModel: courseList[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
