import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:shop_app/helpers/app_storage/app_storage_helper.dart';
import 'package:shop_app/views/auth_screens/login_screen.dart';
import 'package:shop_app/views/home_screens/home_screen.dart';
import 'package:shop_app/views/onboarding_screens/onboarding_screen.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HomeController _homeController = Get.find();
  final AuthController _authController = Get.find();
  Locale? myLocale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // init();

    // _homeController.getHomeData();
    // _homeController.getCategoriesData();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (AppStorage.appStorage.getFirstOpen()) {
        if (AppStorage.appStorage.getToken() != null) {
          Get.off(HomeScreen());
        } else {
          Get.off(const LoginScreen());
        }
      } else {
        Get.off(const OnBoardingScreen());
      }
      // (AppStorage.appStorage.getFirstOpen() &&
      //         AppStorage.appStorage.getToken() != null)
      //     ? Get.off(const HomeScreen())
      //     : (AppStorage.appStorage.getFirstOpen() == false)
      //         ? Get.off(const OnBoardingScreen())
      //         : (AppStorage.appStorage.getFirstOpen() == true &&
      //                 AppStorage.appStorage.getToken() == null)
      //             ? Get.off(const LoginScreen())
      //             : Get.off(const HomeScreen());
    });
  }

  init() async {
    myLocale = Localizations.localeOf(context);
    log(myLocale!.languageCode);
    await _homeController.getHomeData(lang: myLocale!.languageCode);
    await _homeController.getCategoriesData(lang: myLocale!.languageCode);
    await _homeController.getFavoritesData(lang: myLocale!.languageCode);
    await _homeController.getCartData(lang: myLocale!.languageCode);
    await _authController.getUserData(lang: myLocale!.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      body: Center(
        child: CustomText(
          text: 'Splash Screen',
        ),
      ),
    );
  }
}
