import 'package:shop_app/models/cart_models/cart_item_model.dart';
import 'package:shop_app/models/home_models/home_model/products_model.dart';

class DeleteCartDataModel {
  dynamic total;
  dynamic subTotal;
  CartItemModel? cart;

  DeleteCartDataModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    subTotal = json['sub_total'];
    cart= json['cart'] != null ? CartItemModel.fromJson( json['cart']) : null;
  }
}
