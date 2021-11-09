import 'package:aroundus_app/repositories/order_repository/order_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orderForm_state.dart';

class OrderFormCubit extends Cubit<OrderFormState> {
  OrderFormCubit(this._orderRepository) : super(const OrderFormState());

  final OrderRepository _orderRepository;

  Future<void> getOrderForm() async {
    ApiResult<PageResponse> apiResult =
        await _orderRepository.getOrderForm(state.page);

    apiResult.when(success: (PageResponse? pageResponse) {
      emit(state.copyWith(
        orderForm:
            pageResponse!.results!.map((e) => OrderForm.fromJson(e)).toList(),
        count: pageResponse.count,
        page: state.page + 1,
        next: pageResponse.next,
        previous: pageResponse.previous,
        maxIndex: pageResponse.next == null ? true : false,
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        error: error,
        errorMessage: NetworkExceptions.getErrorMessage(error!),
      ));
    });
  }

  Future<void> getOrderFormById(String orderId) async {
    ApiResult<OrderForm> apiResult =
        await _orderRepository.getOrderFormById(orderId);

    apiResult.when(success: (OrderForm? response) {
      emit(state.copyWith(orderForm: [response!]));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        error: error,
        errorMessage: NetworkExceptions.getErrorMessage(error!),
      ));
    });
  }
}
