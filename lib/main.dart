import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/controllers/cart_controller.dart';
import 'package:shop_app/helpers/app_storage/app_storage_helper.dart';
import 'package:shop_app/helpers/network/dio_helper.dart';
import 'package:shop_app/services/app_localizations_services.dart';
import 'package:shop_app/services/theme_services.dart';
import 'package:shop_app/views/auth_screens/login_screen.dart';
import 'package:shop_app/views/auth_screens/register_screen.dart';
import 'package:shop_app/views/onboarding_screens/onboarding_screen.dart';
import 'package:shop_app/services/theme.dart';
import 'package:shop_app/views/splash_screen/splash_screen.dart';

import 'controllers/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('root');
    // final String defaultLocale = Platform.localeName;
    // log('$defaultLocale lannnng');
    Get.put(AuthController());
    Get.put(HomeController());
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => GetMaterialApp(
        title: 'Shop App',
        // theme: Themes.light,
        // darkTheme: Themes.dark,
        // themeMode: ThemeServices().theme,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'PS'),
        ],
        localizationsDelegates: const [
          //a class which loads the translation from JSON files
          AppLocalizationServices.delegate,
          //Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          //Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
        ],
        // locale: const Locale('en', 'US'),

        //Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }

          //If the locale of the device is not supported , use the first one
          return supportedLocales.first;
        },

        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
