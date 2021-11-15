import 'package:aroundus_app/modules/mypage/address/view/address_screen.dart';
import 'package:aroundus_app/repositories/address_repository/models/address.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget orderAddress(BuildContext context, Address address) {
  return Wrap(runSpacing: 15, children: [
    GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddressScreen()));
      },
      child: Container(
          width: sizeWidth(100),
          alignment: Alignment.centerRight,
          child: Text("변경/추가")),
    ),
    address != Address.empty
        ? RichText(
            text: TextSpan(
                style: theme.textTheme.bodyText1!.copyWith(
                    fontSize: Adaptive.dp(14), fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: "${address.name} ${address.phoneNumber}\n",
                  ),
                  TextSpan(
                      text: "${address.bigAddress} ${address.smallAddress}"),
                ]),
          )
        : Container(alignment: Alignment.center, child: Text("배송지가 없습니다.")),
  ]);
}
