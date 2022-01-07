import 'package:shop_app/models/home_models/home_model/products_model.dart';

class CartItemModel {
  ProductModel? product;
  int? id;
  int? quantity;

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }
}
