import 'package:aroundus_app/modules/store/cart/cubit/cart_cubit.dart';
import 'package:aroundus_app/modules/store/order/cubit/order_cubit.dart';
import 'package:aroundus_app/repositories/cart_repository/models/cart.dart';
import 'package:aroundus_app/repositories/cart_repository/src/cart_repository.dart';
import 'package:aroundus_app/repositories/order_repository/src/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_page.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen(this.carts);

  final List<Cart> carts;

  @override
  State<StatefulWidget> createState() => _OrderScreen();
}

class _OrderScreen extends State<OrderScreen> with SingleTickerProviderStateMixin {
  List<Cart> get carts => this.widget.carts;

  late OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = OrderCubit(RepositoryProvider.of<OrderRepository>(context));
    _orderCubit.createOrder(carts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: BlocProvider.value(
        value: _orderCubit,
        child: OrderPage(),
      ),
    );
  }
}
