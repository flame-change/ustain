import 'package:aroundus_app/modules/store/order/cubit/order_cubit.dart';
import 'package:aroundus_app/repositories/order_repository/models/order_item.dart';
import 'package:aroundus_app/support/base_component/blank_widget.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget orderItemTile(OrderCubit orderCubit, OrderItem orderItem) {
  return Column(children: [
    Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
      child: Wrap(
        runSpacing: Adaptive.h(1),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 10,
                      // Todo 브랜드 이미지 삽입
                      backgroundColor: theme.accentColor,
                    ),
                  ),
                  Text("${orderItem.brand}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Adaptive.sp(14))),
                ],
              ),
            ],
          ),
          // 상품 정보
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: Adaptive.h(1), bottom: Adaptive.h(1)),
                child: Image.network(
                  "${orderItem.productThumbnail}",
                  height: sizeWith(20),
                  width: sizeWith(20),
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                child: Container(
                  height: sizeWith(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${orderItem.productName}"),
                      Text("${orderItem.variantName}"),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "수량 : ${orderItem.quantity}개",
                              style: theme.textTheme.subtitle2,
                            ),
                            Text(
                              "${currencyFromString((orderItem.salePrice! * orderItem.quantity!).toString())}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(14)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ]);
}