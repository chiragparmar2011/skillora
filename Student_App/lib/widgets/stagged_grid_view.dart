import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_detail_model.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/subcategory_model.dart';
import 'package:skillora/screen/routes.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_constants.dart';
import 'package:skillora/utilities/app_styles.dart';

class StaggeredGridList extends StatefulWidget {
  const StaggeredGridList({
    this.subCategoryList,
    this.topicList,
    required this.controller,
    this.isTopic = false,
    this.isSubCategory = false,
    super.key,
  });

  final List<SubCategoryModel>? subCategoryList;
  final List<PopularTopics>? topicList;
  final bool isTopic;
  final bool isSubCategory;
  final BaseController controller;

  @override
  State<StaggeredGridList> createState() => _StaggeredGridListState();
}

class _StaggeredGridListState extends State<StaggeredGridList> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: ((getLength() ?? 0) >= 2) ? 2 : 1,
      mainAxisSpacing: 5,
      crossAxisSpacing: 9,
      scrollDirection: Axis.horizontal,
      itemCount: getLength(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (widget.isTopic) {
              widget.controller.navigateTo(
                RoutePath.courseDetail,
                data: {
                  "courseId": widget.topicList?[index].courseId,
                },
              );
            }
            if (widget.isSubCategory) {
              widget.controller.navigateTo(
                RoutePath.subcategory,
                data: {
                  AppConstants.categoryId:
                      widget.subCategoryList?[index].categoryId.toString(),
                  AppConstants.subCategoryId:
                      widget.subCategoryList?[index].id.toString(),
                },
              );
            }
          },
          child: Container(
            constraints: const BoxConstraints(minWidth: 80),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.dropShadow.withValues(alpha: 0.2),
                  spreadRadius: 0.5,
                  blurRadius: 12,
                ),
              ],
              color: AppColors.white,
            ),
            child: Center(
              child: Text(
                getName(index),
                style: TextStyles().textStyle14Black,
              ),
            ),
          ),
        );
      },
    );
  }

  int? getLength() {
    if (widget.isTopic) {
      return widget.topicList?.length ?? 0;
    }
    return widget.subCategoryList?.length ?? 0;
  }

  String getName(int index) {
    if (widget.isTopic) {
      return '${widget.topicList?[index].topicName}';
    }
    return '${widget.subCategoryList?[index].name}';
  }
}
