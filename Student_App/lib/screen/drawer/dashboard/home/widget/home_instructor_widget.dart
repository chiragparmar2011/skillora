import 'package:flutter/material.dart';
import 'package:skillora/helper/globals.dart';
import 'package:skillora/screen/drawer/mentor/model/instructor_model.dart';
import 'package:skillora/translation/localization_delegates.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/widgets/list_header_seeall_widget.dart';
import 'package:skillora/widgets/va_image_asset.dart';

class HomeInstructorWidget extends StatelessWidget {
  const HomeInstructorWidget({
    this.instructorList,
    this.title,
    this.onSeeAllTap,
    required this.onDetailTap,
    super.key,
  });

  final List<InstructorModel>? instructorList;
  final Function()? onSeeAllTap;
  final Function(InstructorModel? data) onDetailTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ((instructorList ?? []).isEmpty)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListHeaderSeeAllWidget(
                title: title ??
                    translate(MyGlobals.navKey.currentContext,
                        'instructor.bestInstructor'),
                onTap: onSeeAllTap,
              ),
              const SizedBox(
                height: 10,
              ),
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
                  itemCount: instructorList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        onDetailTap(instructorList?[index]);
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
                              image: instructorList?[index].image ?? '',
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
