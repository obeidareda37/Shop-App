import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/helpers/app_storage/app_storage_helper.dart';
import 'package:shop_app/services/app_localizations_services.dart';
import 'package:shop_app/services/theme.dart';
import 'package:shop_app/services/toast_service/toast_service.dart';
import 'package:shop_app/views/auth_screens/register_screen.dart';
import 'package:shop_app/views/home_screens/home_screen.dart';
import 'package:shop_app/widgets/custom_button/custom_button_widget.dart';
import 'package:shop_app/widgets/custom_text_field/custom_text_field.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';
import 'dart:developer';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthController _authController = Get.find();

  bool isPassword = false;

  void _requestFocus(focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  Locale? myLocale;

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);

    print('print');
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: AppLocalizationServices.of(context)!
                        .translate('loginTitle')!,
                    fixed: true,
                    style: headingStyle,
                  ),
                  CustomText(
                    text: AppLocalizationServices.of(context)!
                        .translate('loginSubTitle')!,
                    style: subHeadingStyle,
                    fixed: true,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomTextFormField(
                    onFieldSubmitted: (value) {},
                    prefix: Icons.email_outlined,
                    onChange: (value) {},
                    labelText: AppLocalizationServices.of(context)!
                        .translate('emailAddress')!,
                    requestFocus: () {
                      _requestFocus(emailFocusNode);
                    },
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    myFocusNode: emailFocusNode,
                    validate: (value) {
                      if (value!.isEmpty || value == '') {
                        return AppLocalizationServices.of(context)!
                            .translate('validationEmailAddressEmpty');
                      }
                      if (!EmailValidator.validate(value)) {
                        return AppLocalizationServices.of(context)!
                            .translate('validationEmailAddressNotValid');
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  CustomTextFormField(
                    onChange: (value) {},
                    keyboard: TextInputType.text,
                    isPassword: isPassword,
                    suffix: IconButton(
                      icon: Icon(
                        isPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                    ),
                    prefix: Icons.lock_outline,
                    controller: passwordController,
                    labelText: AppLocalizationServices.of(context)!
                        .translate('password')!,
                    requestFocus: () {
                      _requestFocus(passwordFocusNode);
                    },
                    myFocusNode: passwordFocusNode,
                    validate: (value) {
                      if (value!.isEmpty || value == '') {
                        print('empty');
                        return AppLocalizationServices.of(context)!
                            .translate('validationPasswordEmpty');
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      // RouteHelper.routeHelper
                      //     .goToPage(ForgetPassword.routeName);
                    },
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: CustomText(
                        text: AppLocalizationServices.of(context)!
                            .translate('forgetPassword')!,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  GetBuilder<AuthController>(
                    init: _authController,
                    builder: (_) => _authController.isWaiting
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepOrange,
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 60.h,
                            child: CustomButtonWidget(
                              isUpperCase: true,
                              color: Colors.deepOrange,
                              onPressed: () {
                                print('x');
                                loginMethod(myLocale!.languageCode);
                              },
                              text: AppLocalizationServices.of(context)!
                                  .translate('login')!,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: AppLocalizationServices.of(context)!
                            .translate("loginDon'tHaveAccount")!,
                        fontWeight: FontWeight.w500,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(const RegisterScreen());
                        },
                        child: CustomText(
                          text: AppLocalizationServices.of(context)!
                              .translate("register")!
                              .toUpperCase(),
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginMethod([String? lang]) {
    setState(() {
      if (formKey.currentState!.validate()) {
        log('validate ');
        _authController
            .userLogin(
                email: emailController.text,
                password: passwordController.text,
                lang: lang)
            .then((value) {
          log('theen');
          if (_authController.loginModel.status!) {
            log('status true');
            ToastService.toastService.showToast(
                message: _authController.loginModel.message!,
                states: ToastStates.SUCCESS);
            AppStorage.appStorage
                .saveToken(_authController.loginModel.data!.token)
                .then((value) {
              Get.off(HomeScreen());
            });
          } else {
            log('status false');
            ToastService.toastService.showToast(
                message: _authController.loginModel.message!,
                states: ToastStates.ERROR);
          }
        });
        return;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }
}
