import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget cartSummary() {
  return Container(
    width: sizeWith(100),
    margin:
        EdgeInsets.symmetric(horizontal: sizeWith(5), vertical: Adaptive.h(1)),
    child: Column(
      children: [
        summaryOutline(
            title: "총 상품 금액",
            content: "+32000원",
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: Adaptive.sp(14)),
            contentStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Adaptive.sp(14),
                letterSpacing: -1)),
        summaryOutline(
            title: "총 배송비",
            content: "전 상품 무료배송",
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: Adaptive.sp(14)),
            contentStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Adaptive.sp(14),
                letterSpacing: -1)),
        Divider(color: Colors.black12),
        summaryOutline(
            title: "총 결제 예정 금액",
            content: "32000원",
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),
            contentStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Adaptive.sp(16),
                letterSpacing: -1)),
      ],
    ),
  );
}
