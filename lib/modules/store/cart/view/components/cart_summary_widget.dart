import 'package:aroundus_app/repositories/cart_repository/models/cart.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget cartSummary(List<Cart> carts) {

  List<Cart> checkedCart = carts.fold(<Cart>[], (pre, cart) => cart.isChecked!?pre+[cart]:pre+[]);
  final num totalPrice = checkedCart.fold(0, (pre, cart) => pre+(cart.quantity!*cart.salePrice!));

  return Container(
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
                fontWeight: FontWeight.w700, fontSize: Adaptive.dp(14)),
            contentStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Adaptive.sp(14),
                letterSpacing: -1)),
        summaryOutline(
            title: "총 배송비",
            content: "전 상품 무료배송",
            titleStyle: TextStyle(
                height: 1.6,
                fontWeight: FontWeight.w700, fontSize: Adaptive.dp(14)),
            contentStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Adaptive.dp(14),
                letterSpacing: -1)),
        Divider(color: Colors.black12),
        summaryOutline(
            title: "총 결제 예정 금액",
            content: "${currencyFromString(totalPrice.toString())}",
            titleStyle: TextStyle(
                height: 1.6,
                fontWeight: FontWeight.w300, fontSize: Adaptive.dp(16)),
            contentStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: theme.accentColor,
                fontSize: Adaptive.dp(16),
                letterSpacing: -1)),
      ],
    ),
  );
}
