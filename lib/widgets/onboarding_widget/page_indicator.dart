import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class buildPageIndicator extends StatelessWidget {
  final bool isCurrentPage;

  buildPageIndicator(this.isCurrentPage);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 35),
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: 15.h,
      width: 15.w,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.deepOrange : Colors.white54,
        border: isCurrentPage
            ? Border.all(
                color: Colors.deepOrange,
              )
            : Border.all(
                color: const Color(0xff272727),
              ),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
    );
  }
}
