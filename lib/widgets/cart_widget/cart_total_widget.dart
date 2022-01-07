import 'package:flutter/material.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:shop_app/widgets/custom_button/custom_button_widget.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TotalWidget extends StatelessWidget {
  const TotalWidget({
    Key? key,
    required HomeController homeController,
  }) : _homeController = homeController, super(key: key);

  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Total',
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.grey,
              ),
              CustomText(
                text: '${_homeController.cartsModel!.data!.total}\$',
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: Colors.deepOrange,
              ),

            ],
          ),
          Divider(thickness: 1.w,height: 2.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'subTotal',
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.grey,
              ),
              CustomText(
                text: '${_homeController.cartsModel!.data!.subTotal}\$',
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: Colors.deepOrange,
              ),
            ],
          ),
          SizedBox(
            width: 200.w,
            height: 40.h,
            child: MaterialButton(
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadiusDirectional.circular(15.r)),
               splashColor: Colors.transparent,
               highlightColor: Colors.transparent,
               highlightElevation: 0,
               color: Colors.deepOrange,
               onPressed: () {
               },
               child: CustomText(
                 text: 'Checkout',
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: 20.sp,
               ),
             ),
          ),
        ],
      ),
    );
  }
}
