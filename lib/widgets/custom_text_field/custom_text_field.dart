import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/services/theme.dart';

class CustomTextFormField extends StatelessWidget {
  late String labelText;
  String? Function(String? value)? validate;
  String? Function(String? value)? onChange;
  Function? requestFocus;
  FocusNode? myFocusNode;
  TextInputType? keyboard;
  TextEditingController? controller;
  double borderRadius;
  IconData? prefix;
  Widget? suffix;
  void Function(String)? onFieldSubmitted;
  bool isPassword;
  TextSelectionControls? selectionControls;
  String? initialValue;
  TextInputAction? textInputAction;
  CustomTextFormField({
    Key? key,
    required this.labelText,
    this.validate,
    this.onChange,
    this.requestFocus,
    this.myFocusNode,
    this.keyboard,
    this.controller,
    this.borderRadius = 0.0,
    this.prefix,
    this.suffix,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.initialValue,
    this.selectionControls,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction:textInputAction ,
      selectionControls: selectionControls,
      initialValue: initialValue,
      obscureText: isPassword,
      keyboardType: keyboard,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      onTap: () {
        requestFocus!();
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: validate,
      focusNode: myFocusNode,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        suffixIcon: suffix,
        focusColor: Colors.deepOrange,
        labelText: labelText,
        labelStyle: TextStyle(
            color: myFocusNode!.hasFocus ? Colors.deepOrange : Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.deepOrange, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.red, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.red, width: 1.w),
        ),
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );
  }
}
