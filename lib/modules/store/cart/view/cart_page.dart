import 'package:aroundus_app/modules/store/cart/cubit/cart_cubit.dart';
import 'package:aroundus_app/repositories/cart_repository/models/cart.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/base_component/blank_widget.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'components/cart_summary_widget.dart';
import 'components/cart_tile_widget.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartCubit _cartCubit;

  @override
  void initState() {
    super.initState();
    _cartCubit = BlocProvider.of<CartCubit>(context);
    _cartCubit.getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, List<Cart>?>(
        selector: (state) => state.carts,
        builder: (context, carts) {
          if (carts != null) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: Adaptive.h(12)),
                  child: Column(children: [
                    Container(
                      color: Color(0xFFF1F1F1),
                      padding: EdgeInsets.symmetric(horizontal: sizeWith(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Icon(Icons.check_box_rounded)
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                      Icon(Icons.check_box_outline_blank_rounded)),
                              Text("전체선택")
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "선택삭제",
                              style:
                                  TextStyle(decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: List.generate(
                          carts.length, (index) => cartTile(carts[index])),
                    ),
                    Blank(),
                    cartSummary(),
                  ]),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.grey,
                    minWidth: sizeWith(100),
                    height: Adaptive.h(10),
                    child: Text("결제하기"),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Text("아직 장바구니에 담긴 상품이 없어요 😭"),
            );
          }
        });
  }
}
