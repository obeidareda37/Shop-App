import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/helpers/app_storage/app_storage_helper.dart';
import 'package:shop_app/services/app_localizations_services.dart';
import 'package:shop_app/views/auth_screens/login_screen.dart';
import 'package:shop_app/widgets/custom_button/custom_button_widget.dart';
import 'package:shop_app/widgets/onboarding_widget/onboarding_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/widgets/onboarding_widget/page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<Widget> _pages = [
    onBoardingWidget(
      title: 'titleOnBoarding1',
      description: 'descriptionOnBoarding1',
      image: 'assets/images/onboard1.svg',
    ),
    onBoardingWidget(
      title: 'titleOnBoarding2',
      description: 'descriptionOnBoarding2',
      image: 'assets/images/onboard2.svg',
    ),
    onBoardingWidget(
      title: 'titleOnBoarding3',
      description: 'descriptionOnBoarding3',
      image: 'assets/images/onboard3.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // widget.walk =ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: _onChanged,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Container(
            margin: EdgeInsetsDirectional.only(bottom: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < _pages.length; i++)
                      i == _currentPage
                          ? buildPageIndicator(true)
                          : buildPageIndicator(false),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(15.r)),
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  child: CustomButtonWidget(
                      onPressed: () {
                        setState(() {
                          if (_currentPage == 0) {
                            _pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.linear);
                          } else if (_currentPage == 1) {
                            _pageController.animateToPage(2,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.linear);
                          } else {
                            AppStorage.appStorage.saveFirstOpen(true);
                            Get.to(const LoginScreen());
                            // );
                          }
                        });
                      },
                      text: _currentPage == 2
                          ? AppLocalizationServices.of(context)!
                              .translate('buttonStarted')!
                          : AppLocalizationServices.of(context)!
                              .translate('buttonNext')!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
