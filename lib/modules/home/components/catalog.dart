import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CatalogCard extends StatelessWidget {
  const CatalogCard({required this.index});

  final int? index;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(alignment: Alignment.bottomLeft, children: [
        Image.asset(
          'assets/images/1.jpg',
          height: Adaptive.h(30),
          fit: BoxFit.cover,
        ),
        Container(
            margin: EdgeInsets.only(top: Adaptive.h(10)),
            height: Adaptive.h(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [Colors.transparent, Colors.white]))),
        Positioned(
            top: Adaptive.w(5),
            left: Adaptive.w(5),
            child: Container(
                width: 30,
                height: 30,
                color: Colors.black,
                child: Center(
                    child: Text(
                  '$index',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: theme.accentColor, fontWeight: FontWeight.w900),
                )))),
        Padding(
            padding: EdgeInsets.all(Adaptive.w(5)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('#해시태그 제목', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 5),
              Text('어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구 저쩌구 어쩌구구 어쩌구 저쩌구',
                  style: Theme.of(context).textTheme.bodyText2)
            ]))
      ]),
      Padding(
          padding: EdgeInsets.all(Adaptive.w(5)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [CatalogProduct(), CatalogProduct(), CatalogProduct()]))
    ]);
  }
}

class CatalogProduct extends StatelessWidget {
  const CatalogProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Adaptive.w(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/1.jpg',
                fit: BoxFit.cover,
                width: Adaptive.w(25),
                height: Adaptive.w(25)),
          ),
          Text(
            '대충 브랜드 이름',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(height: 1.5, fontSize: 12),
          ),
          Text('대충 상품 이름',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  height: 1.5, fontSize: 12, fontWeight: FontWeight.bold)),
          Text('대충 가격',
              overflow: TextOverflow.fade,
              style: TextStyle(
                  height: 1.5, fontSize: 14, fontWeight: FontWeight.w700))
        ]));
  }
}
