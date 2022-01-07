import 'package:get/get.dart';
import 'package:shop_app/helpers/app_storage/app_storage_helper.dart';
import 'package:shop_app/helpers/network/dio_helper.dart';
import 'package:shop_app/helpers/network/end_points.dart';
import 'package:shop_app/models/cart_models/cart_model.dart';
import 'package:shop_app/models/cart_models/change_cart_model.dart';
import 'package:shop_app/models/cart_models/delete_cart/delete_cart_model.dart';
import 'package:shop_app/models/cart_models/updat_quantity_cart.dart';
import 'package:shop_app/models/favorites_model/change_favorite_model.dart';
import 'package:shop_app/models/favorites_model/favorite_model.dart';
import 'package:shop_app/models/home_models/categories_models/categories_model.dart';
import 'package:shop_app/models/home_models/home_model/home_models.dart';
import 'dart:developer';

class HomeController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  HomeModel? _homeModel;

  HomeModel? get homeModel => _homeModel;
  String? token = AppStorage.appStorage.getToken();

  CategoriesModel? _categoriesModel;

  CategoriesModel? get categoriesModel => _categoriesModel;

  final Map<int, bool> _favorites = {};

  Map<int, bool> get favorites => _favorites;

  final Map<int, bool> _cart = {};

  Map<int, bool> get cart => _cart;

  bool _statusFavorite = false;

  bool get statusFavorite => _statusFavorite;

  bool _statusCart = false;

  bool get statusCart => _statusCart;
  FavoritesModel? _favoritesModel;

  FavoritesModel? get favoritesModel => _favoritesModel;

  CartModel? _cartsModel;

  CartModel? get cartsModel => _cartsModel;

  ChangeFavoriteModel? _changeFavoriteModel;

  ChangeFavoriteModel? get changeFavoriteModel => _changeFavoriteModel;

  ChangeCartModel? _changeCartModel;

  ChangeCartModel? get changeCartModel => _changeCartModel;

  UpdateQuantityCartModel? _updateCart;

  UpdateQuantityCartModel? get updateCart => _updateCart;

  DeleteCartModel? _deleteCartModel;
  DeleteCartModel? get deleteCartModel=>_deleteCartModel;
  int? _quantity;

  int? get quantity => _quantity;


// get Home Data From Api
  Future<void> getHomeData({String? lang}) async {
    _homeModel = null;
    log(token!);
    _isLoading = true;
    await DioHelper.getData(url: HOME, token: token, lang: lang!).then((value) {
      _homeModel = HomeModel.fromJson(value.data);
      // log('${_homeModel!.status}');
      // log('${_homeModel!.data!.banners}');
      for (var element in _homeModel!.data!.products!) {
        _favorites.addAll({
          element.id!: element.inFavorite!,
        });
      }
      for (var element in _homeModel!.data!.products!) {
        _cart.addAll({
          element.id!: element.inCart!,
        });
      }
      log(_favorites.toString());
      _isLoading = false;
      update();
    }).catchError((error) {
      log('$error');
      _isLoading = false;
      update();
    });
    update();
    // log('${homeModel!.status} hommmmmmmmmmme');
    // log('${_homeModel!.status} hommmmmmmmmmme');
  }

// get Categories From Api
  Future<void> getCategoriesData({String? lang}) async {
    log('staart categorrieees');
    // log(token!);
    _isLoading = true;
    await DioHelper.getData(url: GET_CATEGORIES, lang: lang!).then((value) {
      _categoriesModel = CategoriesModel.fromJson(value.data);
      // log('${_categoriesModel!.status}');
      log('${_categoriesModel!.data!.data![0].name} first categories');
      _isLoading = false;
      update();
    }).catchError((error) {
      log('$error');
      _isLoading = false;
      update();
    });
    update();
    // log('${_categoriesModel!.status} categories');
  }

  Future<void> changeFavorite(int productId, {String? lang}) async {
    _favorites[productId] = !_favorites[productId]!;
    update();
    await DioHelper.postData(
            lang: lang!,
            url: FAVORITES,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      _changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      log(_changeFavoriteModel!.message!);
      if (!_changeFavoriteModel!.status!) {
        _favorites[productId] = !_favorites[productId]!;
        _statusFavorite = true;
      } else {
        getFavoritesData();
      }
      update();
    }).catchError((error) {
      _favorites[productId] = !_favorites[productId]!;
      log(error.toString());
      _statusFavorite = true;
      update();
    });
    update();
  }

  Future<void> getFavoritesData({String? lang}) async {
    // log(token!);
    _isLoading = true;
    await DioHelper.getData(url: FAVORITES, token: token, lang: lang!)
        .then((value) {
      _favoritesModel = FavoritesModel.fromJson(value.data);
      log('${_favoritesModel!.status}');
      log('${_favoritesModel!.data!}');
      _isLoading = false;
      update();
    }).catchError((error) {
      log('$error');
      _isLoading = false;
      update();
    });
    update();
    log('${_favoritesModel!.status} favoriteees');
  }

  Future<void> changeCart(int productId, {String? lang}) async {
    _cart[productId] = !_cart[productId]!;
    update();
    await DioHelper.postData(
            lang: lang!,
            url: CARTS,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      _changeCartModel = ChangeCartModel.fromJson(value.data);
      log(_changeCartModel!.message!);
      if (!_changeCartModel!.status!) {
        _cart[productId] = !_cart[productId]!;
        _statusCart = true;
      } else {
        getCartData(lang: lang);
      }
      update();
    }).catchError((error) {
      _cart[productId] = !_cart[productId]!;
      log(error.toString());
      _statusCart = true;
      update();
    });
    update();
  }

  Future<void> getCartData({String? lang}) async {
    // log(token!);
    _isLoading = true;
    await DioHelper.getData(url: CARTS, token: token, lang: lang!)
        .then((value) {
      _cartsModel = CartModel.fromJson(value.data);
      log('${_cartsModel!.status}');
      log('${_cartsModel!.data!}');
      // for (var element in _cartsModel!.data!.cartItem!) {
      //   _quantity = element.quantity;
      // }
      _isLoading = false;
      update();
    }).catchError((error) {
      log('$error');
      _isLoading = false;
      update();
    });
    update();
    log('${_cartsModel!.status} carttt');
  }

  Future<void> updateQuantity(
      {int? cartId, int? quantity, String? lang}) async {
    _isLoading = true;
    await DioHelper.putData(url: 'carts/$cartId', token: token, data: {
      'quantity': quantity,
    }).then((value) {
      _updateCart = UpdateQuantityCartModel.fromJson(value.data);
      log('${_updateCart!.message} cart quantity');
      log('${_updateCart!.status} cart quantity');
      // _quantity = _updateCart!.cart!.quantity;
      if (!_updateCart!.status!) {
        _statusCart = true;
      } else {
         getCartData(lang: lang);
      }
      _isLoading = false;
      update();
    }).catchError((error) {
      log('$error');
      _isLoading = false;
      _statusCart = true;

      update();
    });
    update();
  }

  Future<void> deleteItemCart({int? cartId, String? lang}) async{
    await DioHelper.deleteData(url: 'carts/$cartId', token: token, data: {
    }).then((value) {
      _deleteCartModel = DeleteCartModel.fromJson(value.data);
      log('${_deleteCartModel!.message} cart delete');
      log('${_deleteCartModel!.status} cart delete');
      // _quantity = _updateCart!.cart!.quantity;
      if (!_deleteCartModel!.status!) {
        _statusCart = true;
      } else {
        getCartData(lang: lang);
      }
      _isLoading = false;
      update();
    }).catchError((error) {
      log('$error');
      _isLoading = false;
      _statusCart = true;

      update();
    });
    update();
}
}
