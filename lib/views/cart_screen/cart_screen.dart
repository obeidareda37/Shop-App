import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:shop_app/widgets/cart_widget/cart_item_widget.dart';
import 'package:shop_app/widgets/cart_widget/cart_total_widget.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: _homeController,
      builder: (_) => Scaffold(
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 110.h,
          child: TotalWidget(homeController: _homeController),
          color: Colors.white,
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          title: CustomText(
            text: 'Cart',
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
                  return CartItemWidget(
                    homeController: _homeController,
                    index: index,
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      height: 1.h,
                      thickness: 1.w,
                    ),
                itemCount: _homeController.cartsModel!.data!.cartItem!.length),
      ),
    );
  }
}
