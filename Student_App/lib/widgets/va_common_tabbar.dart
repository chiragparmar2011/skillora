import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillora/screen/drawer/trending/controller/tabbar_controller.dart';
import 'package:skillora/utilities/app_colors.dart';
import 'package:skillora/utilities/app_styles.dart';

class VACommonTabBar extends StatelessWidget {
  const VACommonTabBar({
    required this.tabName,
    this.onTapTab,
    this.tabController,
    super.key,
  });

  final List<String> tabName;
  final Function(int)? onTapTab;
  final ToggleController? tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabName.length,
      initialIndex: tabController?.selectedIndex.value ?? 0,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorSize: TabBarIndicatorSize.tab,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.only(right: 8, left: 0),
        indicatorPadding: EdgeInsets.zero,
        indicatorColor: Colors.transparent,
          tabs: List.generate(
            tabName.length,
            (index) => _buildTab(tabName[index], index),
          ),
          onTap: (index) {
            tabController?.selectedIndex.value = index;
            if (onTapTab != null) {
              onTapTab!(index);
            }
          },
        ),
    );
  }

  Widget _buildTab(String title, int index) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 2, bottom: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
          color: tabController?.selectedIndex == index.obs
              ? AppColors.primaryColor
              : AppColors.white,
        ),
        child: Tab(
          height: 30,
          child: Text(
            title,
            style: TextStyles().textStyleRoboto(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: tabController?.selectedIndex == index.obs
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
