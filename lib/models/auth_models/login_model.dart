import 'package:shop_app/models/auth_models/user_data_model.dart';

class LoginModel {
  bool? status;
  String? message;
  UserDataModel? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? UserDataModel.fromJson(json['data'])
        : null; // ?? null Review
  }
}
