import 'dart:developer';

import 'package:shop_app/models/home_models/home_model/banner_model.dart';
import 'package:shop_app/models/home_models/home_model/products_model.dart';

class HomeDataModel {
  List<BannerModel>? banners = [];
  List<ProductModel>? products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      // log('$element bannnnner');
      banners!.add(BannerModel.fromJson(element));
      // log('${banners![0].image} first image ');
    });
    json['products'].forEach((element) {
      // log('$element products');
      products!.add(ProductModel.fromJson(element));
    });
  }
}
