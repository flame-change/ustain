
import 'package:aroundus_app/modules/store/cart/cubit/cart_cubit.dart';
import 'package:aroundus_app/repositories/cart_repository/src/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_page.dart';

class CartScreen extends StatefulWidget {
  static String routeName = 'cart_screen';

  @override
  State<StatefulWidget> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("장바구니"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => CartCubit(RepositoryProvider.of<CartRepository>(context)),
        child: CartPage(),
      ),
    );
  }
}