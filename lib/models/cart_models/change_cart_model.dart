import 'cart_item_model.dart';

class ChangeCartModel {
  bool? status;
  String? message;
  CartItemModel? data;

  ChangeCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CartItemModel.fromJson(json['data']) : null;
  }
}
