import 'package:aroundus_app/repositories/cart_repository/models/cart.dart';
import 'package:aroundus_app/repositories/order_repository/models/order.dart';
import 'package:aroundus_app/repositories/order_repository/src/order_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._orderRepository) : super(const OrderState());

  final OrderRepository _orderRepository;

  Future<void> createOrder(List<Cart> carts) async {
    List<Map<String, dynamic>> orderItems = carts
        .map((e) => {
              "product": e.productId,
              "variant": e.variantId,
              "quantity": e.quantity,
            })
        .toList();

    ApiResult<Map<String, dynamic>> apiResult = await _orderRepository.createOrder(orderItems);

    apiResult.when(success: (Map<String, dynamic>? mapResponse) {
      print(mapResponse);
      emit(state.copyWith(
        order: Order.fromJson(mapResponse!),
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        error: error,
        errorMessage: NetworkExceptions.getErrorMessage(error!),
      ));
    });
  }
}
