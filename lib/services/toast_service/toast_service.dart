import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

class ToastService {
  ToastService._();

  static ToastService toastService = ToastService._();

  void showToast({required String message, required ToastStates states}) =>
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: choseToastColor(states),
          textColor: Colors.white,
          fontSize: 16.0.sp);

  Color choseToastColor(ToastStates states) {
    Color color;
    switch (states) {
      case ToastStates.SUCCESS:
        color = Colors.green;
        break;
      case ToastStates.ERROR:
        color = Colors.red;
        break;

      case ToastStates.WARNING:
        color = Colors.amber;
        break;
    }
    return color;
  }
}
