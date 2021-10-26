import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class MainCarousel extends StatelessWidget {
  const MainCarousel({
    Key? key,
    required List<String> images,
  })  : _images = images,
        super(key: key);

  final List<String> _images;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        actions: [
          GestureDetector(
              child: Padding(
                  padding: EdgeInsets.only(right: Adaptive.w(5)),
                  child: Icon(Icons.search_outlined, color: Colors.white)))
        ],
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        expandedHeight: Adaptive.h(50),
        floating: false,
        pinned: false,
        flexibleSpace: FlexibleSpaceBar(
            background: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Swiper(
                itemCount: _images.length,
                itemBuilder: (BuildContext context, int index) => Image.asset(
                    _images[index],
                    color: Colors.black12,
                    colorBlendMode: BlendMode.multiply,
                    fit: BoxFit.cover)),
            Padding(
                padding: EdgeInsets.all(Adaptive.w(5)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('해시태그 제목',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white)),
                      SizedBox(height: 5),
                      Text('어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구구 어쩌구 저쩌구',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white))
                    ]))
          ],
        )));
  }
}
