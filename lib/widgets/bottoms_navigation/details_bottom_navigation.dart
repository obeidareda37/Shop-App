import 'package:flutter/material.dart';
import 'package:shop_app/widgets/custom_button/custom_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottomNavigation extends StatelessWidget {
  Function? onPressedCart;
  Function? onPressedFavorite;
  bool? inFavorite = false;
  bool? inCart = false;

  DetailsBottomNavigation(
      {this.inFavorite,
      this.onPressedCart,
      this.onPressedFavorite,
      this.inCart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Row(
        children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.all(10.w),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.orange),
                width: double.infinity,
                child: CustomButtonWidget(
                  onPressed: () {
                    onPressedCart!();
                  },
                  text: inCart! ? 'Remove From Cart' : 'Add To Cart',
                )),
          ),
          GestureDetector(
            onTap: () => onPressedFavorite!(),
            child: CircleAvatar(
              radius: 17.r,
              backgroundColor: Colors.grey[200],
              child: Icon(
                inFavorite! ? Icons.favorite : Icons.favorite_border,
                size: 17,
                color: Colors.deepOrange,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
    );
  }
}
