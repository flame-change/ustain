import 'package:aroundus_app/repositories/cart_repository/models/cart.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget cartTile(Cart cart) {
  return Card(
    margin:
        EdgeInsets.symmetric(horizontal: sizeWith(5), vertical: Adaptive.h(1)),
    color: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: Border(
      bottom: BorderSide(color: Colors.black12, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: // Icon(Icons.check_box_rounded)
                IconButton(
                    onPressed: () {},
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.check_box_outline_blank_rounded))),
        Flexible(
            flex: 4,
            child: Wrap(
              runSpacing: Adaptive.h(1),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: "${cart.productName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(14))),
                            TextSpan(
                                text: "  | ${cart.brand}",
                                style: TextStyle(fontSize: Adaptive.sp(9))),
                          ]),
                    ),
                    IconButton(
                        onPressed: () {},
                        constraints: BoxConstraints.loose(Size.zero),
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.clear))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: Adaptive.h(1), bottom: Adaptive.h(1)),
                      child: Image.network(
                        "${cart.productThumbnail}",
                        height: sizeWith(20),
                        width: sizeWith(20),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: sizeWith(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${cart.variantOptions}"),
                            Text("수량 : ${cart.quantity}개"),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "${cart.salePrice}원",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(14)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ))
      ],
    ),
  );
}
