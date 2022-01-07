import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:shop_app/models/home_models/home_model/products_model.dart';
import 'package:shop_app/services/toast_service/toast_service.dart';
import 'package:shop_app/views/cart_screen/cart_screen.dart';
import 'package:shop_app/widgets/bottoms_navigation/details_bottom_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'package:shop_app/widgets/details_products_screen_widget/item_details_products_widget.dart';
import 'package:shop_app/widgets/details_products_screen_widget/slider_details_products_widget.dart';

class DetailsProductScreen extends StatefulWidget {
  DetailsProductScreen({Key? key, this.products}) : super(key: key);
  ProductModel? products;

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  final HomeController _homeController = Get.find();
  bool inFavorite = false;
  bool inCart = false;
  int quantity = 1;
  Locale? myLocale;

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return GetBuilder(
      init: _homeController,
      builder: (_) {
        _homeController.favorites[widget.products!.id!] == true
            ? inFavorite = true
            : inFavorite = false;

        _homeController.cart[widget.products!.id!] == true
            ? inCart = true
            : inCart = false;
        return Scaffold(
          bottomNavigationBar: DetailsBottomNavigation(
            onPressedCart: () {
              onPressedCart(_homeController, quantity,
                  lang: myLocale!.languageCode);
            },
            inFavorite: inFavorite,
            inCart: inCart,
            onPressedFavorite: () {
              setState(() {});
              onPressedFavorite(_homeController, lang: myLocale!.languageCode);
            },
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 60.w,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              Badge(
                position: const BadgePosition(top: 2, end:5),
                animationDuration: const Duration(milliseconds: 200),
                animationType: BadgeAnimationType.scale,
                showBadge: true,
                badgeColor: Colors.red,
                badgeContent: CustomText(
                  text:
                  '${_homeController.cartsModel!.data!.cartItem!.length}',
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () =>
                      Get.to(CartScreen()),
                  icon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            title: CustomText(
              text: '${widget.products!.name}',
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                SliderDetailsProducts(
                  products: widget.products!,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ItemDetailsProducts(
                  products: widget.products!,
                  incrementQuantity: () => incrementQuantity(),
                  decrementQuantity: () => decrementQuantity(),
                  quantity: quantity,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onPressedFavorite(HomeController homeController, {String? lang}) {
    setState(() {});
    inFavorite = !inFavorite;
    homeController
        .changeFavorite(widget.products!.id!, lang: lang)
        .then((value) {
      if (homeController.statusFavorite) {
        ToastService.toastService
            .showToast(message: 'حدث خطا', states: ToastStates.ERROR);
        inFavorite = false;
      }
    });
  }

  void onPressedCart(HomeController homeController, int quantity,
      {String? lang}) {
    setState(() {
      inCart = !inCart;
      homeController
          .changeCart(widget.products!.id!, lang: myLocale!.languageCode)
          .then((value) {
        ToastService.toastService.showToast(
            message: _homeController.changeCartModel!.message!,
            states: ToastStates.SUCCESS);
        homeController.updateQuantity(
            cartId: homeController.changeCartModel!.data!.id,
            lang: lang,
            quantity: quantity);
        if (homeController.statusCart) {
          ToastService.toastService
              .showToast(message: 'حدث خطا', states: ToastStates.ERROR);
        }
      });
    });
  }

  void decrementQuantity() {
    setState(() {});
    if (quantity > 0) {
      quantity--;
      log('${quantity} decriment');
    }
  }

  void incrementQuantity() {
    setState(() {
      if (quantity >= 0 && quantity < 20) {
        quantity++;
        log('${quantity} increment');
      }
    });
  }
}
