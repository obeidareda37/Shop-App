import 'package:flutter/material.dart';
import 'package:shop_app/widgets/custom_text_widget/custom_text_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomText(
        text: 'Search Screen',
        fixed: true,
        style: subHeadingStyle,
      ),
    );;
  }
}
