import 'package:aroundus_app/repositories/order_repository/models/order_item.dart';
import 'package:aroundus_app/support/base_component/summary_outline.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget orderPayment(List<OrderItem> orderItems) {
  final num totalPrice = orderItems.fold(0, (pre, cart) => pre + (cart.quantity! * cart.salePrice!));

  return Wrap(runSpacing: 15, children: [
    Container(
      width: sizeWith(100),
      margin: EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      child: Column(
        children: [
          summaryOutline(
              title: "총 상품 금액",
              content: "${currencyFromString(totalPrice.toString())}",
              titleStyle: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                  fontSize: Adaptive.dp(14)),
              contentStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Adaptive.sp(14),
                  letterSpacing: -1)),
          summaryOutline(
              title: "총 배송비",
              content: "전 상품 무료배송",
              titleStyle: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                  fontSize: Adaptive.dp(14)),
              contentStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Adaptive.dp(14),
                  letterSpacing: -1)),
          summaryOutline(
              title: "포인트 할인 금액",
              // content: "${currencyFromString(totalPrice.toString())}",
              content: "0원",
              titleStyle: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                  fontSize: Adaptive.dp(14)),
              contentStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Adaptive.sp(14),
                  letterSpacing: -1)),
          Divider(color: Colors.black12),
          summaryOutline(
              title: "총 결제 예정 금액",
              content: "${currencyFromString(totalPrice.toString())}",
              titleStyle: TextStyle(
                  height: 1.6,
                  color: theme.accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Adaptive.dp(16)),
              contentStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: theme.accentColor,
                  fontSize: Adaptive.dp(16),
                  letterSpacing: -1)),
        ],
      ),
    ),
  ]);
}
