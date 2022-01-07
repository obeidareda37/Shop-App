// import 'dart:developer';
//
// import 'package:get/get.dart';
// import 'package:shop_app/helpers/app_storage/app_storage_helper.dart';
// import 'package:shop_app/helpers/network/dio_helper.dart';
// import 'package:shop_app/helpers/network/end_points.dart';
// import 'package:shop_app/models/cart_models/cart_model.dart';
//
// class CartController extends GetxController {
//   bool? _isWaiting = false;
//
//   bool? get isWaiting => true;
//
//   String? token = AppStorage.appStorage.getToken();
//
//   CartModel? _cartModel;
//
//   CartModel? get cartModel => _cartModel;
//
//   Future<void> addToCart(int productId, {String? lang}) async {
//     _isWaiting = true;
//     await DioHelper.postData(
//             url: CARTS,
//             data: {
//               'product_id': productId,
//             },
//             token: token,
//             lang: lang!)
//         .then((value) {
//       _cartModel = CartModel.fromJson(value.data);
//       log('${_cartModel!.status}');
//       log('${_cartModel!.message}');
//       _isWaiting = false;
//       update();
//     }).catchError((error) {
//       log(error.toString());
//       _isWaiting = false;
//       update();
//     });
//     update();
//   }
// }
