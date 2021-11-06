import 'package:aroundus_app/modules/store/order/cubit/order_cubit.dart';
import 'package:aroundus_app/modules/store/order/cubit/payment_cubit.dart';
import 'package:aroundus_app/repositories/order_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/base_component/plain_button.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamport_flutter/model/payment_data.dart';

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';

import 'order_result_page.dart';

/* 아임포트 결제 데이터 모델을 불러옵니다. */
// import 'package:iamport_flutter/model/payment_data.dart' as \;

class OrderPaymentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage> {
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
    return SafeArea(
      child: BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
        if (state.isLoaded) {
          return IamportPayment(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              centerTitle: false,
              title: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login_home_screen');
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded)),
            ),
            initialChild: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                      child: Text('잠시만 기다려주세요...',
                          style: TextStyle(fontSize: 20.0)),
                    ),
                  ],
                ),
              ),
            ),

            userCode: 'imp03489525',
            // 가맹점 식별코드

            /* [필수입력] 결제 데이터 */
            data: PaymentData(
              pg: 'nice',
              // PG사
              payMethod: 'card',
              // 결제수단
              name: '아임포트 결제데이터 분석',
              // 주문명
              merchantUid: '${state.order!.merchantUid}',
              // 주문번호
              amount: state.order!.amount!.toInt(),
              // 결제금액
              buyerName: '${state.order!.buyerName}',
              // 구매자 이름
              buyerTel: '${state.order!.buyerTel}',
              // 구매자 연락처
              buyerEmail: '${state.order!.buyerEmail}',
              // 구매자 이메일
              buyerAddr: '${_orderCubit.state.orderTemp!.address!.bigAddress}',
              // 구매자 주소
              buyerPostcode:
                  '${_orderCubit.state.orderTemp!.address!.postalCode}',
              // 구매자 우편번호
              appScheme: 'aroundus', // 앱 URL scheme
              // display : {
              //   'cardQuota' : [2,3]                                            //결제창 UI 내 할부개월수 제한
              // }
            ),
            /* [필수입력] 콜백 함수 */
            callback: (Map<String, String> result) {
              print("아임포트 result ---- $result");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderResultPage(result)));
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         elevation: 0,
//       ),
//       body: BlocBuilder<PaymentCubit, PaymentState>(
//         builder: (context, state) {
//           if (state.isLoaded) {
//             return BlocSelector<PaymentCubit, PaymentState, Order>(
//                 selector: (state) => state.order!,
//                 builder: (context, order) {
//                   return PageWire(
//                     child: Stack(
//                       children: [
//                         Text("$order"),
//                         Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Wrap(
//                             runSpacing: 10,
//                             spacing: 10,
//                             children: [
//                               PlainButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     Navigator.pop(context);
//                                     // Navigator.pushNamedAndRemoveUntil(
//                                     //     context, 'cart_screen', (route) => false);
//                                   },
//                                   text: "장바구니로 돌아가기"),
//                               PlainButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   Navigator.pop(context);
//                                   Navigator.pop(context);
//                                   Navigator.pop(context);
//                                 },
//                                 text: "더 둘러보기",
//                                 color: Colors.white,
//                                 borderColor: theme.accentColor,
//                               ),
//                               SizedBox(height: 0)
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 });
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ));
// }
}
