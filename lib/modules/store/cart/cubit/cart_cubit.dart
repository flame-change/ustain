import 'package:aroundus_app/repositories/cart_repository/cart_repository.dart';
import 'package:aroundus_app/repositories/cart_repository/models/cart.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartRepository) : super(const CartState());

  final CartRepository _cartRepository;

  Future<void> getCartList() async {
    ApiResult<List> apiResult = await _cartRepository.getCartList();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        carts: listResponse!
            .map((cart) => Cart.fromJson(cart).copyWith(isChecked: true))
            .toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  void selectedCart(Cart cart) {
    emit(state.copyWith(
        carts: state.carts!
            .map((e) =>
                e == cart ? cart.copyWith(isChecked: !cart.isChecked!) : e)
            .toList()));
  }
}
