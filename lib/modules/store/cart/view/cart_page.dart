
import 'package:aroundus_app/modules/store/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  late CartCubit _cartCubit;

  @override
  void initState() {
    super.initState();
    _cartCubit = BlocProvider.of<CartCubit>(context);
    _cartCubit.getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("아직 장바구니에 담긴 상품이 없어요 😭"),
    );
  }
}