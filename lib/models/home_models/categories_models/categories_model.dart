import 'dart:developer';

import 'package:shop_app/models/home_models/categories_models/categories_data_model.dart';

class CategoriesModel {
   bool? status;
   CategoriesDataModel? data;

  CategoriesModel({ this.status,  this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
    // log('${data!} categoriesssss');
  }
}
