import 'package:aroundus_app/modules/orderForm/cubit/orderForm_cubit.dart';
import 'package:aroundus_app/repositories/order_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class OrderFormPage extends StatefulWidget {
  OrderFormPage(this.orderId);

  final String orderId;

  @override
  State<StatefulWidget> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage>
    with SingleTickerProviderStateMixin {
  String get orderId => this.widget.orderId;

  late OrderFormCubit _orderFormCubit;

  @override
  void initState() {
    super.initState();
    _orderFormCubit = BlocProvider.of<OrderFormCubit>(context);
    _orderFormCubit.getOrderFormById(orderId);
    print(_orderFormCubit.state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: GestureDetector(
              child: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
              onTap: () {
                Navigator.pushNamed(context, 'main_screen');
              }),
          actions: [
          ],
        ),
        body: BlocBuilder<OrderFormCubit, OrderFormState>(
          builder: (context, state) {
            return PageWire(
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("2021.11.05", style: theme.textTheme.headline4),
                      Blank(color: Colors.black, height: 6),
                      Row(
                        children: [
                          Image.network('https://t1.daumcdn.net/cfile/tistory/2771283953F58A0C29', width: 85, height: 85, fit: BoxFit.cover,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("[아디다스오리지널] 블랙 러닝신발", style: theme.textTheme.headline5),
                                Text("SIZE: 265 / COLOR : WHITE", style: theme.textTheme.subtitle2!.copyWith(fontSize: Adaptive.dp(10)),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("수량 : 1개"),
                                    Text("135,900원", style: theme.textTheme.headline5),
                                  ],
                                ),
                              ],
                            ),
                          )

                        ],
                      ),
                    ],
                  ),
                )
            );
          },
        ));
  }
}
