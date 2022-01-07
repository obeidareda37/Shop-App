import 'dart:developer';

import 'package:shop_app/models/home_models/categories_models/data_model.dart';

class CategoriesDataModel {
   int? currentPage;
   List<DataModel>? data=[];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data!.add(DataModel.fromJson(element));
      // log('${data!.length} lenghttttt');
    });
  }
}
