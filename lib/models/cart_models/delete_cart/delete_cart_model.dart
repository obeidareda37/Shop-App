import 'package:shop_app/models/cart_models/cart_item_model.dart';
import 'package:shop_app/models/cart_models/delete_cart/delete_cart_data_model.dart';
class DeleteCartModel {
  bool? status;
  String? message;
  DeleteCartDataModel? data;

  DeleteCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DeleteCartDataModel.fromJson(json['data']) : null;
  }
}
