import 'package:aroundus_app/modules/mypage/address/cubit/address_cubit.dart';
import 'package:aroundus_app/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:aroundus_app/modules/store/order/cubit/order_cubit.dart';
import 'package:aroundus_app/modules/store/order/cubit/payment_cubit.dart';
import 'package:aroundus_app/repositories/order_repository/models/models.dart';
import 'package:aroundus_app/repositories/order_repository/models/order_temp.dart';
import 'package:aroundus_app/repositories/order_repository/src/order_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'views.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderCubit _orderCubit;
  late AddressCubit _addressCubit;
  late CouponCubit _couponCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = BlocProvider.of<OrderCubit>(context);
    _addressCubit = BlocProvider.of<AddressCubit>(context);
    _couponCubit = BlocProvider.of<CouponCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
      if (state.isLoaded) {
        return BlocSelector<OrderCubit, OrderState, OrderTemp>(
            selector: (state) => state.orderTemp!,
            builder: (context, orderTemp) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: Adaptive.h(10)),
                    child: PageWire(
                      child: Wrap(
                        children: [
                          orderCompose(
                            title: "주문상품 (${orderTemp.products!.length}건)",
                            child: Column(
                              children: List.generate(
                                  orderTemp.products!.length,
                                  (index) => orderItemTile(
                                      _orderCubit, orderTemp.products![index])),
                            ),
                          ),
                          orderCompose(
                              title: "쿠폰 사용",
                              child: orderCoupon(context, orderTemp.coupon,
                                  _couponCubit, _orderCubit)),
                          orderCompose(
                            title: "배송지/주문자 정보",
                            child: orderAddress(context, orderTemp.address!),
                          ),
                          orderCompose(
                              title: "배송 요청사항",
                              child: orderDelivery(
                                  context, orderTemp.request!, _orderCubit),
                              isRequired: true),
                          orderCompose(
                              title: "결제 수단", child: Text("아임포트 확인할 것")),
                          orderCompose(
                              title: "결제 정보",
                              child: orderPayment(orderTemp.products!)),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("주문 내역 확인 동의 및 결제 동의",
                                      style: theme.textTheme.bodyText1),
                                  IconButton(
                                      onPressed: () {
                                        _orderCubit.setAgreed();
                                      },
                                      icon: Icon(
                                        state.agreed
                                            ? Icons.check_box_rounded
                                            : Icons
                                                .check_box_outline_blank_rounded,
                                        color: Color(0xFFC4C4C4),
                                      )),
                                ],
                              ),
                              Text(
                                  "주문 상품의 상세 정보, 가격, 환불정책 등을  확인하였으며, 이에 동의합니다.",
                                  style: TextStyle(
                                      color: Color(0xFFC4C4C4),
                                      fontWeight: FontWeight.w400,
                                      fontSize: Adaptive.dp(12))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        if (state.agreed &&
                            state.selectedShippingRequest != null) {
                          // Order 생성 페이지로 이동

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MultiBlocProvider(providers: [
                                        BlocProvider<OrderCubit>.value(
                                            value: _orderCubit),
                                        BlocProvider(
                                            create: (_) => PaymentCubit(
                                                RepositoryProvider.of<
                                                    OrderRepository>(context)))
                                      ], child: OrderPaymentPage())),
                              (route) => false);
                          // OrderResultPage
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("필수 항목을 채워주세요."),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("확인"),
                                    ),
                                  ],
                                );
                              });
                        }
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
