import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';

class CategoriesItemWidget extends StatelessWidget {
  CategoriesItemWidget(
      {Key? key, required HomeController homeController, required this.index})
      : _homeController = homeController,
        super(key: key);

  final HomeController _homeController;
  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w.h),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
                _homeController.categoriesModel!.data!.data![index].image!),
            width: 80.w,
            height: 80.h,
          ),
          SizedBox(
            width: 20.w,
          ),
          CustomText(
            text: _homeController.categoriesModel!.data!.data![index].name!,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
