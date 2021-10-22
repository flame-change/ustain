import 'package:aroundus_app/modules/store/cart/cubit/cart_cubit.dart';
import 'package:aroundus_app/repositories/cart_repository/models/cart.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget cartTile(CartCubit cartCubit, Cart cart) {
  return Column(
    children: [
      Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: // Icon(Icons.check_box_rounded)
                    GestureDetector(
                        onTap: () {
                          cartCubit.selectedCart(cart);
                        },
                        child: cart.isChecked!
                            ? Icon(Icons.check_box_rounded)
                            : Icon(Icons.check_box_outline_blank_rounded))),
            // 브랜드 정보
            Flexible(
                flex: 8,
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
                            Text("${cart.brand}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(14))),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            cartCubit.deleteCart([cart]);
                          },
                          child: Icon(Icons.clear),
                        )
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
                            "${cart.productThumbnail}",
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
                                Text("${cart.productName}"),
                                Text("${cart.variantName}"),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "수량 : ${cart.quantity}개",
                                        style: theme.textTheme.subtitle2,
                                      ),
                                      Text(
                                        "${currencyFromString((cart.salePrice! * cart.quantity!).toString())}",
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
                ))
          ],
        ),
      ),
      Blank(height: 1),
    ],
  );
}
