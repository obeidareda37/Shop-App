import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  late String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;
  FontStyle? fontStyle;
  TextAlign? textAlign;
  TextDirection? textDirection;
  bool fixed;
  TextStyle? style;
  TextOverflow? overflow;
  int? maxLines;
  TextDecoration? decoration;

  CustomText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.fontStyle,
    this.textAlign,
    this.textDirection,
    this.fixed = false,
    this.style,
    this.overflow,
    this.maxLines,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: fixed
          ? style
          : TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: fontFamily,
              fontStyle: fontStyle,
              decoration: decoration,
            ),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
  ));
}
TextStyle get headingStyle1 {
  return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.grey,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  ));
}

TextStyle get bodyStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  ));
}

TextStyle get body2Style {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    height: 1.1.h,
    color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  ));
}
