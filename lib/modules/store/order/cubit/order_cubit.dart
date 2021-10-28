import 'package:aroundus_app/repositories/cart_repository/models/cart.dart';
import 'package:aroundus_app/repositories/coupon_repository/models/coupon.dart';
import 'package:aroundus_app/repositories/order_repository/models/models.dart';
import 'package:aroundus_app/repositories/order_repository/models/order.dart';
import 'package:aroundus_app/repositories/order_repository/models/order_item.dart';
import 'package:aroundus_app/repositories/order_repository/src/order_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._orderRepository) : super(const OrderState());

  final OrderRepository _orderRepository;

  void setAgreed() {
    emit(state.copyWith(agreed: !state.agreed));
  }

  void setDeliveryMessage(String message) {
    emit(state.copyWith(
      order: state.order!.copyWith(
       request: state.order!.request!.copyWith(
         additionalRequest: message
       )
      )
    ));
  }

  void setShippingRequest(ShippingRequest shippingRequest) {
    emit(state.copyWith(
        order: state.order!.copyWith(request: state.order!.request!.copyWith(
            shippingRequest: [shippingRequest]))
        ));
    }

  Future<Coupon?> getCoupon(dynamic couponId) async {
    ApiResult<Coupon> apiResult = await _orderRepository.getCoupon(couponId);

    apiResult.when(success: (Coupon? response) {
      emit(state.copyWith(
        order: state.order!.copyWith(coupon: response),
        isLoading: false,
        isLoaded: true,
      ));
      return response;
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> createOrder(List<Cart> carts) async {
    List<OrderItem> orderItems = carts
        .map((e) =>
        OrderItem(
            brand: e.brand,
            productId: e.productId,
            productName: e.productName,
            productThumbnail: e.productThumbnail,
            variantId: e.variantId,
            variantName: e.variantName,
            salePrice: e.salePrice!.toInt(),
            quantity: e.quantity!.toInt(),
            Id: e.Id))
        .toList();

    ApiResult<Map<String, dynamic>> apiResult =
    await _orderRepository.createOrder(orderItems);

    apiResult.when(success: (Map<String, dynamic>? mapResponse) {
      print(mapResponse);
      print("mapResponse ${mapResponse!["request"]}");
      emit(state.copyWith(
        order: Order.fromJson(mapResponse),
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
