import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:shop_app/models/home_models/home_model/products_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';

class ItemDetailsProducts extends StatefulWidget {
  ItemDetailsProducts({
    Key? key,
    required this.products,
    this.incrementQuantity,
    this.decrementQuantity,
    this.quantity,
  }) : super(key: key);

  final ProductModel products;
  final HomeController _homeController = Get.find();
  Function? incrementQuantity;
  Function? decrementQuantity;
  int? quantity;

  @override
  State<ItemDetailsProducts> createState() => _ItemDetailsProductsState();
}

class _ItemDetailsProductsState extends State<ItemDetailsProducts> {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Container(
        padding: EdgeInsets.all(8.w),
        margin: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: '${widget.products.name}',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
              text: '${widget.products.description}',
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                CustomText(
                    text: '\$ ${widget.products.price} ',
                    fontSize: 20.sp,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w800),
                SizedBox(
                  width: 20.w,
                ),
                if (widget.products.discount! != 0)
                  CustomText(
                    text: '${widget.products.oldPrice!.round()}',
                    fontSize: 12.0.sp,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                const Spacer(),
                Container(
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Colors.deepOrange),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                        widget.decrementQuantity!();
                        },
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r),
                            color: Colors.white),
                        child: Text(
                          '${widget.quantity}',
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.incrementQuantity!();
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
