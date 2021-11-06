import 'package:aroundus_app/repositories/order_repository/order_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orderForm_state.dart';

class OrderFormCubit extends Cubit<OrderFormState> {
  OrderFormCubit(this._orderRepository) : super(const OrderFormState());

  final OrderRepository _orderRepository;

  Future<Map?> getOrderLedgerById(String orderId) async {
    ApiResult<Map> apiResult =
        await _orderRepository.getOrderLedgerById(orderId);

    apiResult.when(
        success: (Map? mapResponse) {
          emit(state.copyWith(
            orderForm: mapResponse!
          ));
        },
        failure: (NetworkExceptions? error) {
          emit(state.copyWith(
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error!),
          ));
        });
  }
}
