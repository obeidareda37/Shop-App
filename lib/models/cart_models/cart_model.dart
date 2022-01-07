import 'package:shop_app/models/cart_models/cart_data_model.dart';

class CartModel {
  bool? status;
  CartDataModel? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CartDataModel.fromJson(json['data']) : null;
  }
}
