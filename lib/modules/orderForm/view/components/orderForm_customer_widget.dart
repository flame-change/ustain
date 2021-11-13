import 'package:flutter/material.dart';

import 'orderForm_base_component.dart';

Widget orderFormCustomerWidget(Map customerInfo) {
  print(customerInfo);
  return orderFormBaseComponent(
    title: "주문자 정보",
    children: [
      ListTile(
        title: Text("구매자 성명"),
        trailing: Text("${customerInfo["name"]}"),
        contentPadding: EdgeInsets.zero,
      ),
      ListTile(
        title: Text("연락처"),
        trailing: Text("${customerInfo["mobile"]}"),
        contentPadding: EdgeInsets.zero,
      ),
    ]
  );
}