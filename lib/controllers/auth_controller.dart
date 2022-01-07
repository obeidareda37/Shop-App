import 'package:get/get.dart';
import 'package:shop_app/helpers/app_storage/app_storage_helper.dart';
import 'package:shop_app/helpers/network/dio_helper.dart';
import 'package:shop_app/helpers/network/end_points.dart';
import 'package:shop_app/models/auth_models/login_model.dart';
import 'dart:developer';

import 'package:shop_app/views/auth_screens/login_screen.dart';

class AuthController extends GetxController {
  bool _isWaiting = false;

  bool get isWaiting => _isWaiting;

  LoginModel _loginModel = LoginModel();

  LoginModel get loginModel => _loginModel;

  LoginModel? _registerModel;

  LoginModel? get registerModel => _registerModel;

  LoginModel? _userModel;

  LoginModel? get userModel => _userModel;

  String? token = AppStorage.appStorage.getToken();

  Future<void> userLogin(
      {required String email, required String password, String? lang}) async {
    log('first');
    _isWaiting = true;
    await DioHelper.postData(
      url: LOGIN,
      lang: lang!,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // log('${value.data} data');
      _loginModel = LoginModel.fromJson(value.data);
      // log('${_loginModel.status}');
      // log('${_loginModel.message}');
      // log('${_loginModel.data!.token}');
      _isWaiting = false;
      update();
    }).catchError((error) {
      // print(error);
      // log('$error');
      _isWaiting = false;
      update();
    });

    update();
  }

  Future<void> userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone,
      String? lang}) async {
    log('first');
    _isWaiting = true;
    await DioHelper.postData(
            url: REGISTER,
            data: {
              'email': email,
              'password': password,
              'name': name,
              'phone': phone
            },
            lang: lang!)
        .then((value) {
      // log('${value.data} data');
      _registerModel = LoginModel.fromJson(value.data);
      log('${_registerModel!.status}');
      log('${_registerModel!.message}');
      // log('${_registerModel.data!.token}');
      _isWaiting = false;
      update();
    }).catchError((error) {
      // print(error);
      // log('$error');
      _isWaiting = false;
      update();
    });

    update();
  }

  Future<void> getUserData({String? lang}) async {
    _isWaiting = true;
    await DioHelper.getData(url: PROFILE, token: token, lang: lang!)
        .then((value) {
      _userModel = LoginModel.fromJson(value.data);
      log(_userModel!.data!.name!);
      _isWaiting = false;
      update();
    }).catchError((error) {
      _isWaiting = false;
      update();
    });
    update();
  }

  Future<void> updateProfile(
      {required String email,
      required String name,
      required String phone,
      String? lang}) async {
    _isWaiting = true;

    await DioHelper.putData(url: UPDATE_PROFILE, lang: lang!, data: {
      'email': email,
      'name': name,
      'phone': phone,
    }).then((value) {
      _userModel = LoginModel.fromJson(value.data);
      _isWaiting = false;
      update();
    }).catchError((error) {
      _isWaiting = false;

      print(error.toString());
      update();
    });
    update();
  }

  Future<void> logOut() async {
    await AppStorage.appStorage.removeToken().then((value) {
      Get.offAll(const LoginScreen());
      update();
    });
  }
}
