import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/views/cart_screen/cart_screen.dart';
import 'package:shop_app/widgets/drawer_widget/drawer_item_widget.dart';

class DrawerScreen extends StatelessWidget {
  static const routeName = 'DrawerMenu';
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 250.h,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150.h,
                      margin: EdgeInsetsDirectional.only(top: 30.h),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            DrawerItemWidget(
              text: 'Cart',
              onTap: () => Get.to(CartScreen()),
              icon: Icons.shopping_bag,
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              thickness: 1.h,
            ),
            DrawerItemWidget(
              text: 'Favorite',
              onTap: () => Get.to(CartScreen()),
              icon: Icons.favorite,
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              thickness: 1.h,
            ),
            DrawerItemWidget(
              text: 'Change Mode',
              onTap: () {},
              icon: Icons.lightbulb,
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              thickness: 1.h,
            ),
            DrawerItemWidget(
              text: 'Logout',
              onTap: () {
                authController.logOut();
              },
              icon: Icons.restaurant_rounded,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
