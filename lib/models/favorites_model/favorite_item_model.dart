import 'package:shop_app/models/home_models/home_model/products_model.dart';

class FavoriteItemModel {
  int? id;
  ProductModel? product;

  FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }
}
