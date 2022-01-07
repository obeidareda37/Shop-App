import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Banners extends StatefulWidget {
  Banners({
    Key? key,
    required HomeController homeController,
  })  : _homeController = homeController,
        super(key: key);

  final HomeController _homeController;

  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider(
          items: widget._homeController.homeModel!.data!.banners!.map((e) {
            return CachedNetworkImage(
              imageUrl: e.image!,
              width: double.infinity,
              fit: BoxFit.cover,
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
              onPageChanged: (index, r) {
                position = index;
                setState(() {});
              },
              height: 250.0.h,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 8),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal),
        ),
        DotsIndicator(
          dotsCount: widget._homeController.homeModel!.data!.banners!.length,
          position: position.toDouble(),
          decorator: DotsDecorator(
            activeColor: Colors.deepOrange,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0.r)),
          ),
        )
      ],
    );
  }
}
