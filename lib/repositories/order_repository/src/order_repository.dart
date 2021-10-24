import 'package:aroundus_app/repositories/order_repository/models/order.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';

class OrderRepository {
  OrderRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<Map<String, dynamic>>> createOrder(List<dynamic> orderItems) async {
    try {
      var response = await _dioClient.postWithClayful('/api/v1/commerce/order/order-temp/', data: orderItems);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}