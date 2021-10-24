import 'package:aroundus_app/modules/store/order/cubit/order_cubit.dart';
import 'package:aroundus_app/repositories/order_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'components/order_address_widget.dart';
import 'components/order_compose_widget.dart';
import 'components/order_coupon_widget.dart';
import 'components/order_delivery_widget.dart';
import 'components/order_orderItem_tile_widget.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = BlocProvider.of<OrderCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
      if (state.isLoaded) {
        return BlocSelector<OrderCubit, OrderState, Order>(
            selector: (state) => state.order!,
            builder: (context, order) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: Adaptive.h(10)),
                    child: PageWire(
                      child: Wrap(
                        children: [
                          orderCompose(
                            title: "주문상품 (0)건",
                            // child: Column(
                            //   children: List.generate(
                            //       order.products!.length,
                            //       (index) => orderItemTile(
                            //           _orderCubit, order.products![index])),
                            // ),
                          ),
                          orderCompose(title: "쿠폰 사용", child: orderCoupon()),
                          orderCompose(title: "배송지/주문자 정보", child: orderAddress(order.address!)),
                          orderCompose(title: "배송 요청사항", child: orderDelivery(order.request!)),
                          orderCompose(title: "결제 수단", child: Text("아임포트 확인할 것")),
                          orderCompose(title: "결제 정보"),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        print("결제 페이지로 이동");
                      },
                      child: Container(
                        height: Adaptive.h(10),
                        width: sizeWith(100),
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: Text(
                          "결제하기",
                          style: theme.textTheme.button!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              );
            });
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
