import 'package:aroundus_app/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:aroundus_app/repositories/coupon_repository/models/coupon.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget couponTile(CouponCubit couponCubit, Coupon coupon, bool isSelected) {
  return Column(
    children: [
      Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: isSelected
                    ? Icon(Icons.radio_button_checked)
                    : Icon(Icons.radio_button_off)),
            // 브랜드 정보
            Flexible(
                flex: 15,
                child: Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(left: 15),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Wrap(
                    runSpacing: 15,
                    children: [
                      Text("${coupon.name}",
                          style: TextStyle(fontSize: Adaptive.sp(16))),
                      // 쿠폰 정보
                      Container(
                        width: sizeWidth(100),
                        child: Wrap(
                          runSpacing: 10,
                          children: [
                            Text("${coupon.name}"),
                            Text("${coupon.description}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ],
  );
}
