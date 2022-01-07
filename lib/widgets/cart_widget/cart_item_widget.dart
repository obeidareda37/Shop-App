import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/cart_models/cart_item_model.dart';
import 'package:shop_app/services/toast_service/toast_service.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget({
    Key? key,
    required this.index,
    required HomeController homeController,
  })  : _homeController = homeController,
        super(key: key);

  int index;
  final HomeController _homeController;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int quantity;
  Function? incrementQuantity;
  Function? decrementQuantity;
  Locale? myLocale;

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    List<CartItemModel> carts =
        widget._homeController.cartsModel!.data!.cartItem!;
    quantity = carts[widget.index].quantity!;
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 1,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (BuildContext context) {
              widget._homeController
                  .deleteItemCart(
                      cartId: carts[widget.index].id,
                      lang: myLocale!.languageCode)
                  .then((value) {
                if (widget._homeController.statusCart) {
                  ToastService.toastService
                      .showToast(message: 'حدث خطا', states: ToastStates.ERROR);
                }
              });
            },
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: SizedBox(
          height: 120.h,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(carts[widget.index].product!.image!),
                    width: 120.w,
                    height: 120.h,
                  ),
                  if (carts[widget.index].product!.discount != 0)
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
                      text: carts[widget.index].product!.name!,
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
                          text:
                              '${carts[widget.index].product!.price!.round()}',
                          fontSize: 12.0.sp,
                          color: Colors.deepOrange,
                        ),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        if (carts[widget.index].product!.discount! != 0)
                          CustomText(
                            text:
                                '${carts[widget.index].product!.oldPrice!.round()}',
                            fontSize: 12.0.sp,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        const Spacer(),
                        Row(
                          children: [
                            CustomText(
                              text: 'quantity: ',
                              fontSize: 14.sp,
                            ),
                            CustomText(
                              text: '$quantity',
                              color: Colors.deepOrange,
                              fontSize: 20.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
