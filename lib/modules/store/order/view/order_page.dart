
import 'package:aroundus_app/modules/store/order/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Center(
      child: Text("${_orderCubit.state}"),
    );
  }

}
