import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'package:shop_app/widgets/favorite_widget/favorite_item_widget.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: _homeController,
        builder: (_) => Scaffold(
         appBar: AppBar(
            backgroundColor: Colors.grey[50],
            title: CustomText(
              text: 'Favorite',
              color: Colors.black,
            ),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            ),
            leadingWidth: 50.w,
          ),
              body: _homeController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return FavoriteItemWidget(
                          homeController: _homeController,
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                            height: 1.h,
                            thickness: 1.w,
                          ),
                      itemCount:
                          _homeController.favoritesModel!.data!.data!.length),
            ));
  }
}
