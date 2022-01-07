import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/home_models/home_model/products_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderDetailsProducts extends StatefulWidget {
  SliderDetailsProducts({
    Key? key,
    required this.products,
  }) : super(key: key);

  final ProductModel products;

  @override
  State<SliderDetailsProducts> createState() => _SliderDetailsProductsState();
}

class _SliderDetailsProductsState extends State<SliderDetailsProducts> {
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: CarouselSlider(
            items: widget.products.images!.map((e) {
              return CachedNetworkImage(
                imageUrl: e!,
                width: double.infinity,
                errorWidget: (context, url, err) => const Center(
                  child: Icon(Icons.image),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
                onPageChanged: (index, reason) {
                  position = index;
                  setState(() {});
                },
                height: 250.0.h,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal),
          ),
        ),
        DotsIndicator(
          dotsCount: widget.products.images!.length,
          position: position.toDouble(),
          decorator: DotsDecorator(
            activeColor: Colors.deepOrange,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }
}
