import 'package:shop_app/models/cart_models/cart_item_model.dart';
import 'package:shop_app/models/home_models/home_model/products_model.dart';

class CartDataModel {
  dynamic total;
  dynamic subTotal;
  List<CartItemModel>? cartItem = [];

  CartDataModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    subTotal = json['sub_total'];

    json['cart_items'].forEach((element) {
      cartItem!.add(CartItemModel.fromJson(element));
    });
  }
}
