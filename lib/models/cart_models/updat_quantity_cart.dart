import 'package:shop_app/models/cart_models/cart_item_model.dart';

class UpdateQuantityCartModel {
  bool? status;
  String? message;
  CartItemModel? cart;

  UpdateQuantityCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cart = json['cart'] != null ? CartItemModel.fromJson(json['cart']) : null;
  }
}
