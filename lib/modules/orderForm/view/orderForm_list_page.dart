import 'package:aroundus_app/modules/orderForm/cubit/orderForm_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderFormListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderFormListPageState();
}

class _OrderFormListPageState extends State<OrderFormListPage> {
  late OrderFormCubit _orderFormCubit;

  @override
  void initState() {
    super.initState();
    _orderFormCubit = BlocProvider.of<OrderFormCubit>(context);
    _orderFormCubit.getOrderForm();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderFormCubit, OrderFormState>(
        builder: (context, state) {
      return Center(child: Text("a"));
    });
  }
}
