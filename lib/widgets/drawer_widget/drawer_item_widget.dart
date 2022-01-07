import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
class DrawerItemWidget extends StatelessWidget {
  String text;
  IconData icon;
  Function onTap;

  DrawerItemWidget(
      {required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            SizedBox(
              width: 30.w,
            ),
            CustomText(
              text: text,
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ],
        ),
      ),
    );
  }
}
