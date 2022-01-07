import 'dart:developer';

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  String? description;
  List<dynamic>? images;
  bool? inFavorite;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    description = json['description'];
    if (json['images'] != null) {
      images = <dynamic>[];
      json['images'].forEach((v) {
        images!.add(v);
        // log('${images![0]} firssssssst imaage');

      });
    }
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];

  }
}
