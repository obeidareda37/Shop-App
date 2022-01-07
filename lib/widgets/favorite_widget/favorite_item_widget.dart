import 'package:flutter/material.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/favorites_model/favorite_item_model.dart';
import 'package:shop_app/models/favorites_model/favorite_model.dart';
import 'package:shop_app/services/toast_service/toast_service.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';

class FavoriteItemWidget extends StatelessWidget {
  FavoriteItemWidget({
    Key? key,
    required this.index,
    required HomeController homeController,
  })  : _homeController = homeController,
        super(key: key);

  int index;
  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    List<FavoriteItemModel> favorites =
        _homeController.favoritesModel!.data!.data!;
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        height: 120.h,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(favorites[index].product!.image!),
                  width: 120.w,
                  height: 120.h,
                ),
                if (favorites[index].product!.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: CustomText(
                      text: 'DISCOUNT',
                      color: Colors.white,
                      fontSize: 8.sp,
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomText(
                    text: favorites[index].product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    fixed: true,
                    style: body2Style,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: '${favorites[index].product!.price!.round()}',
                        fontSize: 12.0.sp,
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        width: 5.0.w,
                      ),
                      if (favorites[index].product!.discount! != 0)
                        CustomText(
                          text:
                              '${favorites[index].product!.oldPrice!.round()}',
                          fontSize: 12.0.sp,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          _homeController
                              .changeFavorite(favorites[index].product!.id!)
                              .then((value) {
                            if (_homeController.statusFavorite) {
                              ToastService.toastService.showToast(
                                  message: 'حدث خطا',
                                  states: ToastStates.ERROR);
                            }
                          });
                        },
                        icon: CircleAvatar(
                            radius: 17.r,
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              _homeController.favorites[
                                          favorites[index].product!.id!] ==
                                      true
                                  ? Icons.favorite: Icons.favorite_border,
                              size: 17,
                              color: Colors.deepOrange,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
