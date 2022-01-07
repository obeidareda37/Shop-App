import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/models/auth_models/login_model.dart';
import 'package:shop_app/services/app_localizations_services.dart';
import 'package:shop_app/services/toast_service/toast_service.dart';
import 'package:shop_app/widgets/custom_button/custom_button_widget.dart';
import 'package:shop_app/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final AuthController _authController = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Locale? myLocale;
  late FocusNode emailFocusNode;
  late FocusNode nameFocusNode;
  late FocusNode phoneFocusNode;
  bool isPassword = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _requestFocus(focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return GetBuilder<AuthController>(
        init: _authController,
        builder: (_) {
          LoginModel? model = _authController.userModel;
          nameController.text = model!.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          return Scaffold(
              body: _authController.userModel == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            if (_authController.isWaiting)
                              const LinearProgressIndicator(
                                color: Colors.deepOrange,
                              ),
                            SizedBox(
                              height: 50.h,
                            ),
                            CustomTextFormField(
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {},
                              prefix: Icons.person,
                              onChange: (value) {},
                              labelText: AppLocalizationServices.of(context)!
                                  .translate('userName')!,
                              requestFocus: () {
                                _requestFocus(nameFocusNode);
                              },
                              keyboard: TextInputType.text,
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
                              height: 20.h,
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
                                      .translate(
                                          'validationEmailAddressNotValid');
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.h,
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
                              height: 20.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 55.h,
                              child: CustomButtonWidget(
                                color: Colors.deepOrange,
                                onPressed: () {
                                  updateMethod(myLocale!.languageCode);
                                },
                                text:
                                    '${AppLocalizationServices.of(context)!.translate('update')}',
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 55.h,
                              child: CustomButtonWidget(
                                color: Colors.deepOrange,
                                onPressed: () {
                                  _authController.logOut();
                                },
                                text:
                                    '${AppLocalizationServices.of(context)!.translate('logOut')}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
        });
  }

  void updateMethod([String? languageCode]) {
    setState(() {
      if (formKey.currentState!.validate()) {
        log('validate ');
        _authController
            .updateProfile(
                email: emailController.text,
                name: nameController.text,
                phone: phoneController.text,
                lang: myLocale!.languageCode)
            .then((value) {
          log('theen');
          if (_authController.userModel!.status!) {
            log('status true');
            ToastService.toastService.showToast(
                message: _authController.userModel!.message!,
                states: ToastStates.SUCCESS);
            // AppStorage.appStorage
            //     .saveToken(_authController.registerModel!.data!.token)
            //     .then((value) {
            //   Get.off( HomeScreen());
            // });
          } else {
            log('status false');
            ToastService.toastService.showToast(
                message: _authController.userModel!.message!,
                states: ToastStates.ERROR);
          }
        });
        return;
      }
    });
  }
}
