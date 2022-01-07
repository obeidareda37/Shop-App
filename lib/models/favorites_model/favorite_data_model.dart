import 'package:shop_app/models/favorites_model/favorite_item_model.dart';

class FavoriteDataModel{
  int? currentPage;
  List<FavoriteItemModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavoriteItemModel>[];
      json['data'].forEach((v) {
        data!.add(FavoriteItemModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}