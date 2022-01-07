import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/views/cart_screen/cart_screen.dart';
import 'package:shop_app/views/drawer_screen/drawer_screen.dart';
import 'package:shop_app/views/home_screens/favorite_screen.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'package:shop_app/widgets/home_widget/banners_widget.dart';
import 'package:shop_app/widgets/home_widget/categories_list_item_widget.dart';
import 'package:shop_app/widgets/home_widget/product_grid_item_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: _homeController,
        builder: (_) {
          return Scaffold(
            drawer: DrawerScreen(),

            appBar: AppBar(
              title: CustomText(
                text: 'Shop',
                color: Colors.black,
              ),
              backgroundColor: Colors.grey[100],
              leadingWidth: 50.w,
              leading: Builder(
                builder: (context) => IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.view_headline,
                    color: Colors.black,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(FavoriteScreen());
                  },
                  icon: const Icon(
                    Icons.favorite_outlined,
                    color: Colors.black,
                  ),
                ),
                Badge(
                  position: const BadgePosition(top: 2, end: 5),
                  animationDuration: const Duration(milliseconds: 200),
                  animationType: BadgeAnimationType.scale,
                  showBadge: true,
                  badgeColor: Colors.red,
                  badgeContent: CustomText(
                    text: _homeController.cartsModel == null
                        ? '0'
                        : '${_homeController.cartsModel!.data!.cartItem!.length}',
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () => Get.to(CartScreen()),
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: _homeController.homeModel == null &&
                    _homeController.categoriesModel == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Banners(homeController: _homeController),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Categories',
                                style: headingStyle1,
                                fixed: true,
                              ),
                              SizedBox(
                                height: 10.0.h,
                              ),
                              SizedBox(
                                height: 100.h,
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        CategoriesListItemWidget(
                                          homeController: _homeController,
                                          index: index,
                                        ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                    itemCount:
                                        _homeController.categoriesModel == null
                                            ? 0
                                            : _homeController.categoriesModel!
                                                .data!.data!.length),
                              ),
                              SizedBox(
                                height: 20.0.h,
                              ),
                              CustomText(
                                text: 'New Products',
                                style: headingStyle1,
                                fixed: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 1.h,
                            crossAxisSpacing: 1.w,
                            childAspectRatio: 1 / 1.55,
                            children: List.generate(
                              _homeController.homeModel!.data!.products!.length,
                              (index) => ProductGridItemWidget(
                                homeController: _homeController,
                                index: index,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
