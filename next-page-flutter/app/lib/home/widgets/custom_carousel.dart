import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../model/tmp_carousel.dart';


class CustomCarousel extends StatefulWidget {

  const CustomCarousel({Key? key}) : super(key: key);

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      CarouselSlider(
        options: CarouselOptions(
          height: size.height * 0.35,
          initialPage: 0, //초기 캐러셀 이미지 인덱스
          enableInfiniteScroll: true, // 무한 반복 여부
          autoPlay: true,	//자동 실행 여부
          autoPlayInterval: const Duration(seconds: 8), //캐러셀 이미지 전환 간격
          viewportFraction: 1, //정해진 width 에 표시할 캐러셀 이미지의 크기 비율
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
          reverse: false,
        ),
        items: TmpCarousel.carouselList.map((carousel) {
          return Builder(
            builder: (BuildContext context) {
              return Image.asset(
                carousel.path,
                width: size.width,
                fit: BoxFit.fill,
              );
            },
          );
        }).toList(),
      ),
      SizedBox(height: size.height * 0.01),
      Container(
        height: 1,
        color: Colors.grey.withOpacity(0.3),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(TmpCarousel.carouselList.length, (index) {
            return Container(
              width: 8,
              height: 10,
              margin: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Colors.white
                    : Colors.white.withOpacity(0.4),
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
