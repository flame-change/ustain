
import 'package:aroundus_app/repositories/cart_repository/cart_repository.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartRepository) : super(const CartState());

  final CartRepository _cartRepository;

}