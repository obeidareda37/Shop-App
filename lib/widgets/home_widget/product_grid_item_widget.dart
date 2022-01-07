import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/home_models/home_model/products_model.dart';
import 'package:shop_app/services/toast_service/toast_service.dart';
import 'package:shop_app/views/home_screens/details_products_screen.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';

class ProductGridItemWidget extends StatelessWidget {
  const ProductGridItemWidget(
      {Key? key, required HomeController homeController, required this.index})
      : _homeController = homeController,
        super(key: key);

  final HomeController _homeController;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<ProductModel>? products = _homeController.homeModel!.data!.products!;

    // log('${products[index].images!} products image');
    // log(products[index].name!);
    return GestureDetector(
      onTap: () => Get.to(DetailsProductScreen(
        products: products[index],
      )),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(products[index].image!),
                  width: double.infinity,
                  height: 200.h,
                ),
                if (products[index].discount! != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: CustomText(
                      text: 'DISCOUNT',
                      color: Colors.white,
                      fontSize: 8.sp,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: products[index].name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    fixed: true,
                    style: body2Style,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.h),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: CustomText(
                          text: '${products[index].price!.round()}\$',
                          fontSize: 12.0.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 5.0.w,
                      ),
                      if (products[index].discount! != 0)
                        CustomText(
                          text: '${products[index].oldPrice!.round()}\$',
                          fontSize: 12.0.sp,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          _homeController
                              .changeFavorite(products[index].id!)
                              .then((value) {
                            if (_homeController.statusFavorite) {
                              ToastService.toastService.showToast(
                                  message: 'حدث خطا',
                                  states: ToastStates.ERROR);
                            }
                          });
                        },
                        icon: CircleAvatar(
                            radius: 17.r,
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              _homeController.favorites[products[index].id!] ==
                                      true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 17,
                              color: Colors.deepOrange,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
