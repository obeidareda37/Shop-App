import 'package:flutter/material.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesListItemWidget extends StatelessWidget {
  CategoriesListItemWidget(
      {Key? key, required HomeController homeController, required this.index})
      : _homeController = homeController,
        super(key: key);

  final HomeController _homeController;
  int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
                _homeController.categoriesModel!.data!.data![index].image!),
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(.8),
            child: CustomText(
              text: _homeController.categoriesModel!.data!.data![index].name!,
              color: Colors.white,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
