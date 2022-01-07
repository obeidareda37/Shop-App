import 'package:flutter/material.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  Function() onPressed;

  String text;
  Color? color;
  bool isUpperCase;

  CustomButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.color,
      this.isUpperCase = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10.r)),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      highlightElevation: 0,
      color: color,
      onPressed: () {
        onPressed();
      },
      child: CustomText(
        text: isUpperCase ? text.toUpperCase() : text,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
      ),
    );
  }
}
