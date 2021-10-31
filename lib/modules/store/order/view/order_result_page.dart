import 'package:aroundus_app/modules/store/order/cubit/order_cubit.dart';
import 'package:aroundus_app/modules/store/order/cubit/payment_cubit.dart';
import 'package:aroundus_app/modules/store/store_home/view/store_home_screen.dart';
import 'package:aroundus_app/repositories/order_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderResultPageState();
}

class _OrderResultPageState extends State<OrderResultPage> {
  late OrderCubit _orderCubit;
  late PaymentCubit _paymentCubit;

  late Map<String, dynamic> orderTemp;

  @override
  void initState() {
    super.initState();
    _orderCubit = BlocProvider.of<OrderCubit>(context);
    _paymentCubit = BlocProvider.of<PaymentCubit>(context);
    orderTemp = {
      "products": _orderCubit.state.orderTemp!.products!
          .map((p) => p.toJson())
          .toList(),
      "address": _orderCubit.state.orderTemp!.address!.toJson(),
      "request": {
        "shippingRequest": _orderCubit.state.selectedShippingRequest!.toJson(),
        "additionalRequest":
            _orderCubit.state.orderTemp!.request!.additionalRequest
      },
      "coupon": _orderCubit.state.orderTemp!.coupon!.toJson(),
      "agreed": _orderCubit.state.agreed
    };
    _paymentCubit.createOrder(orderTemp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state.isLoaded) {
              return BlocSelector<PaymentCubit, PaymentState, Order>(
                  selector: (state) => state.order!,
                  builder: (context, order) {
                    return PageWire(
                      child: Stack(
                        children: [
                          Text("$order"),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: [
                                PlainButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      // Navigator.pushNamedAndRemoveUntil(
                                      //     context, 'cart_screen', (route) => false);
                                    },
                                    text: "장바구니로 돌아가기"),
                                PlainButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  text: "더 둘러보기",
                                  color: Colors.white,
                                  borderColor: theme.accentColor,
                                ),
                                SizedBox(height: 0)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
