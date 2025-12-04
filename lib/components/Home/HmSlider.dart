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
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  _getSlider() {
    return CarouselSlider(
      carouselController: _carouselController,
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
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  _getSearch() {
    return Positioned(
      left: 20,
      top: 20,
      right: 20,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "搜索...",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  _getDots() {
    if (widget.bannerList.isEmpty) {
      return SizedBox.shrink();
    }

    return Positioned(
      bottom: 15,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.bannerList.length, (index) {
          final isSelected = index == _currentIndex;
          return GestureDetector(
            onTap: () {
              _carouselController.animateToPage(index);
              setState(() {
                _currentIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: isSelected ? 20 : 6,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : Color.fromRGBO(255, 255, 255, 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
