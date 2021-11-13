import 'package:flutter/material.dart';

import 'orderForm_base_component.dart';

Widget orderFormAddressWidget(Map addressInfo) {
  print(addressInfo);
  return orderFormBaseComponent(
    title: "배송지 정보",
    children: [
      ListTile(
        title: Text("우편번호"),
        trailing: Text("${addressInfo["postcode"]}"),
        contentPadding: EdgeInsets.zero,
      ),
      ListTile(
        title: Text("주소"),
        trailing: Text("${addressInfo["address"]}"),
        contentPadding: EdgeInsets.zero,
      ),
    ]
  );
}