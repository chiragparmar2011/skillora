import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:skillora/screen/base_controller.dart';
import 'package:skillora/screen/drawer/dashboard/home/category/model/category_model.dart';
import 'package:skillora/services/api_services.dart';
import 'package:skillora/services/connection/connectivity_mixin.dart';

class CategoryController extends BaseController with ConnectivityMixin {
  TextEditingController searchController = TextEditingController();
  RxList<CategoryModel>? categoryList = <CategoryModel>[].obs;

  void getCategories() async {
    try {
      changeLoaderStatus(true);
      categoryList?.value = await ApiServices().getAllCategories() ?? [];
      categoryList?.refresh();
    } catch (e) {
      e.toString();
    }
    changeLoaderStatus(false);
  }

  @override
  onInitSetup() {
    getCategories();
  }
}
