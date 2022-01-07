import 'package:shop_app/models/favorites_model/favorite_data_model.dart';

class FavoritesModel {
  bool? status;
  FavoriteDataModel? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? FavoriteDataModel.fromJson(json['data']) : null;
  }


}
