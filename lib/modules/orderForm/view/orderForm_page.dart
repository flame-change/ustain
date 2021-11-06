import 'package:aroundus_app/modules/orderForm/cubit/orderForm_cubit.dart';
import 'package:aroundus_app/repositories/order_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _orderFormCubit.getOrderLedgerById(orderId);
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
                child: Center(child: Text("${_orderFormCubit.state}")));
          },
        ));
  }
}
