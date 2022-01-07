import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/services/app_localizations_services.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class onBoardingWidget extends StatelessWidget {
  String title;
  String description;
  String image;

  onBoardingWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 70.h),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomText(
            text: AppLocalizationServices.of(context)!.translate(title)!,
            fontSize: 25.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50.w),
            child: CustomText(
              text: AppLocalizationServices.of(context)!.translate(description)!,
              fontSize: 17.sp,
              maxLines: 2,
              textAlign: TextAlign.center,
              color: const Color(0xff4D4D4D),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
