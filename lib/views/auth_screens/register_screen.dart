import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/services/app_localizations_services.dart';
import 'package:shop_app/services/toast_service/toast_service.dart';
import 'package:shop_app/views/auth_screens/login_screen.dart';
import 'package:shop_app/widgets/custom_button/custom_button_widget.dart';
import 'package:shop_app/widgets/custom_text_field/custom_text_field.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late FocusNode emailFocusNode;
  late FocusNode nameFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode phoneFocusNode;
  bool isPassword = false;
  Locale? myLocale;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _requestFocus(focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    // log(myLocale!.languageCode);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0.h),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                CustomText(
                  text: AppLocalizationServices.of(context)!
                      .translate('registerTitle')!,
                  style: headingStyle,
                  fixed: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  text: AppLocalizationServices.of(context)!
                      .translate('registerSubTitle')!,
                  style: subHeadingStyle,
                  fixed: true,
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomTextFormField(
                  prefix: Icons.person,
                  keyboard: TextInputType.text,
                  onChange: (value) {},
                  labelText: AppLocalizationServices.of(context)!
                      .translate('fullName')!,
                  requestFocus: () {
                    _requestFocus(nameFocusNode);
                  },
                  controller: nameController,
                  myFocusNode: nameFocusNode,
                  validate: (value) {
                    if (value!.isEmpty || value == '') {
                      return AppLocalizationServices.of(context)!
                          .translate('validationFullNameEmpty');
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextFormField(
                  prefix: Icons.email_outlined,
                  keyboard: TextInputType.emailAddress,
                  onChange: (value) {},
                  labelText: AppLocalizationServices.of(context)!
                      .translate('emailAddress')!,
                  requestFocus: () {
                    _requestFocus(emailFocusNode);
                  },
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
                  height: 15.h,
                ),
                CustomTextFormField(
                  onFieldSubmitted: (value) {},
                  prefix: Icons.phone,
                  onChange: (value) {},
                  labelText: AppLocalizationServices.of(context)!
                      .translate('phoneNumber')!,
                  requestFocus: () {
                    _requestFocus(phoneFocusNode);
                  },
                  keyboard: TextInputType.phone,
                  controller: phoneController,
                  myFocusNode: phoneFocusNode,
                  validate: (value) {
                    if (value!.isEmpty || value == '') {
                      return AppLocalizationServices.of(context)!
                          .translate('validationPhoneNumberEmpty');
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextFormField(
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
                  keyboard: TextInputType.text,
                  onChange: (value) {},
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
                  height: 30.w,
                ),
                GetBuilder<AuthController>(
                  init: _authController,
                  builder: (_) => SizedBox(
                    width: double.infinity,
                    height: 60.h,
                    child: CustomButtonWidget(
                      isUpperCase: true,
                      color: Colors.deepOrange,
                      onPressed: () {
                        print('x');
                        registerMethod(myLocale!.languageCode);
                      },
                      text: AppLocalizationServices.of(context)!
                          .translate('register')!,
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
                          .translate('doYouHaveAccount')!,
                      fontWeight: FontWeight.w500,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const LoginScreen());
                      },
                      child: CustomText(
                        text: AppLocalizationServices.of(context)!
                            .translate('login')!
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
    );
  }

  void registerMethod([String? languageCode]) {
    setState(() {
      if (formKey.currentState!.validate()) {
        log('validate ');
        _authController
            .userRegister(
                email: emailController.text,
                password: passwordController.text,
                name: nameController.text,
                phone: phoneController.text,
                lang: languageCode)
            .then((value) {
          log('theen');
          if (_authController.registerModel!.status!) {
            log('status true');
            ToastService.toastService.showToast(
                message: _authController.registerModel!.message!,
                states: ToastStates.SUCCESS);
            Get.off(const LoginScreen());
            // AppStorage.appStorage
            //     .saveToken(_authController.registerModel!.data!.token)
            //     .then((value) {
            //   Get.off( HomeScreen());
            // });
          } else {
            log('status false');
            ToastService.toastService.showToast(
                message: _authController.registerModel!.message!,
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
    emailFocusNode.dispose();
    nameFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }
}
