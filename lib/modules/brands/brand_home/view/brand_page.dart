import 'package:aroundus_app/modules/brands/brand_home/components/brand_list_card.dart';
import 'package:aroundus_app/modules/brands/brand_home/components/categories.dart';
import 'package:aroundus_app/modules/brands/brand_home/models/RecipeBundel.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

class BrandPage extends StatefulWidget {
  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: <Widget>[
      Categories(),
      Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recipeBundles.length,
                  itemBuilder: (context, index) => BrandListCard(
                        brandcard: recipeBundles[index],
                        press: () {},
                      ))))
    ]));
  }
}
