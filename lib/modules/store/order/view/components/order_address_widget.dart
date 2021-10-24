import 'package:aroundus_app/repositories/address_repository/models/address.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget orderAddress(Address address) {
  return Wrap(runSpacing: 15, children: [
    Container(
        width: sizeWith(100),
        alignment: Alignment.centerRight,
        child: Text("변경/추가")),
    RichText(
      text: TextSpan(
          style: theme.textTheme.bodyText1!
              .copyWith(fontSize: Adaptive.dp(14), fontWeight: FontWeight.w400),
          children: [
            TextSpan(
              text: "${address.name} ${address.phoneNumber}\n",
            ),
            TextSpan(text: "${address.bigAddress} ${address.smallAddress}"),
          ]),
    ),
  ]);
}
