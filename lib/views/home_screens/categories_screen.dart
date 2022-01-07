import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:shop_app/widgets/categories_widget/categories_item_Widget.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: _homeController,
      builder: (_) => Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) {
              return CategoriesItemWidget(
                  homeController: _homeController, index: index);
            },
            separatorBuilder: (context, index) => Divider(
                  height: 1.h,
                  thickness: 1,
                ),
            itemCount: _homeController.categoriesModel!.data!.data!.length),
      ),
    );
  }
}
