import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/utils/ScreenUtils.dart' as SreenUtils;
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  const HmSlider({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  _getSlider() {
    return CarouselSlider(
      items: widget.bannerList.map((item) {
        return Image.network(
          item.imgUrl!,
          fit: BoxFit.cover,
          width: SreenUtils.getSreenWidth(context),
        );
      }).toList(),
      options: CarouselOptions(
        height: 250,
        autoPlay: true,
        autoPlayCurve: Curves.linear,
        autoPlayInterval: Duration(seconds: 2),
        viewportFraction: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider()]);
  }
}
