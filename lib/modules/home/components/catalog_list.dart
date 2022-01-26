import 'package:aroundus_app/repositories/magazine_repository/models/catalog.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

class CatalogCard extends StatelessWidget {
  const CatalogCard(this.catalog, this.index);

  final Catalog? catalog;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(alignment: Alignment.bottomLeft, children: [
        Image.network(catalog!.bannerImage!,
            height: sizeWidth(60), width: sizeWidth(100), fit: BoxFit.cover),
        Container(
            margin: EdgeInsets.only(top: sizeWidth(40)),
            height: sizeWidth(20) + 1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [Colors.white.withOpacity(0), Colors.white]))),
        Positioned(
            top: sizeWidth(5),
            left: sizeWidth(5),
            child: Container(
                width: sizeWidth(8),
                height: sizeWidth(8),
                color: Colors.black,
                child: Center(
                    child: Text('$index',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900))))),
        Padding(
            padding: EdgeInsets.all(sizeWidth(5)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('#${catalog!.title!}',
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 5),
              Text(catalog!.description!,
                  style: Theme.of(context).textTheme.bodyText2)
            ]))
      ]),
      Padding(
          padding: EdgeInsets.all(sizeWidth(5)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var catalog in catalog!.products!) CatalogProduct(catalog)
              ]))
    ]);
  }
}

class CatalogProduct extends StatelessWidget {
  CatalogProduct(this._catalogProducts);

  final Map<dynamic, dynamic> _catalogProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: sizeWidth(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(_catalogProducts['thumbnail'],
                  fit: BoxFit.cover,
                  width: sizeWidth(25),
                  height: sizeWidth(25))),
          Text(_catalogProducts['brand'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(height: 1.5, fontSize: Adaptive.dp(9))),
          Text(_catalogProducts['name'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  height: 1.5,
                  fontSize: Adaptive.dp(9),
                  fontWeight: FontWeight.bold)),
          Text(currencyFromString(_catalogProducts['discountPrice'].toString()),
              overflow: TextOverflow.fade,
              style: TextStyle(
                  height: 1.5,
                  fontSize: Adaptive.dp(11),
                  fontWeight: FontWeight.w700))
        ]));
  }
}
