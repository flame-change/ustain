import 'package:aroundus_app/support/base_component/blank_widget.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';

import 'orderForm_base_component.dart';

Widget orderFormPaymentsWidget(Map paymentInfo) {
  return orderFormBaseComponent(title: "결제 정보", children: [
    ListTile(
      title: Text("상품 금액"),
      trailing: Text(
          "${currencyFromString(paymentInfo["totalOriginalPrice"].toString())}"),
      contentPadding: EdgeInsets.zero,
    ),
    ListTile(
      title: Text("총 할인 금액"),
      trailing: Text(
          "${currencyFromString(paymentInfo["totalDiscountedPrice"].toString())}"),
      contentPadding: EdgeInsets.zero,
    ),
    ListTile(
      title: Text("총 구매 금액"),
      trailing: Text(
          "${currencyFromString(paymentInfo["totalSalePrice"].toString())}"),
      contentPadding: EdgeInsets.zero,
    ),
  ]);
}
