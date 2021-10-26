import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget orderCoupon() {
  return Wrap(runSpacing: 15, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("쿠폰 할인가"),
      RichText(
        text: TextSpan(style: theme.textTheme.bodyText1, children: [
          TextSpan(
              text: "10,000",
              style: TextStyle(
                  color: theme.accentColor, fontWeight: FontWeight.w700)),
          TextSpan(text: "원"),
        ]),
      ),
    ]),
    Row(
      children: [
        Container(
          height: 30,
          width: Adaptive.w(60),
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Text("선택한 쿠폰 이름"),
        ),
        Expanded(
          child: Container(
            height: 30,
            color: Colors.black,
            alignment: Alignment.center,
            child: Text(
              "쿠폰 선택하기",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  ]);
}
