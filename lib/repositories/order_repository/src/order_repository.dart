import 'package:aroundus_app/repositories/order_repository/models/order_temp.dart';
import 'package:aroundus_app/repositories/coupon_repository/models/coupon.dart';
import 'package:aroundus_app/repositories/order_repository/models/models.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';

class OrderRepository {
  OrderRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<Coupon>> getCoupon(String couponId) async {
    try {
      var response = await _dioClient
          .getWithClayful('/api/v1/commerce/coupon/detail/${couponId}/');

      return ApiResult.success(data: Coupon.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<OrderTemp>> createOrderTemp(List<dynamic> orderItems) async {
    try {
      var response = await _dioClient.postWithClayful(
          '/api/v1/commerce/cart/order-temp/',
          data: orderItems);
      return ApiResult.success(data: OrderTemp.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Order>> createOrder(Map<String, dynamic> orderItems) async {
    try {
      var response = await _dioClient
          .postWithClayful('/api/v1/commerce/order/create/', data: orderItems);
      return ApiResult.success(data: Order.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<OrderForm>> getOrderFormById(String orderId) async {
    try {
      var response =
          await _dioClient.getWithClayful('/api/v1/commerce/order/$orderId/');
      return ApiResult.success(data: OrderForm.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<PageResponse>> getOrderForm(int page) async {
    try {
      var response = await _dioClient
          .getWithClayful('/api/v1/commerce/order/list/?page=$page');
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult> cancelOrder(String? orderId, String? reason) async {
    try {
      var response = await _dioClient.postWithClayful(
          '/api/v1/commerce/order/cancel/',
          data: {'orderId': orderId, 'reason': reason});
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
