import 'dart:developer';

import 'package:shop_app/models/home_models/home_model/home_data_model.dart';

class HomeModel {
  bool? status;
   HomeDataModel? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
    // log('${data!.products} dataaaa');
  }
}
