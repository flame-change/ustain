import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';

class CountGetFailure implements Exception {}

class CartRepository {
  CartRepository(this._dioClient);

  final DioClient _dioClient;

  Future<int> getCartCount() async {
    try {
      var response =
          await _dioClient.getWithClayful('/api/v1/commerce/cart/count-items/');

      return response;
    } on Exception {
      throw CountGetFailure();
    }
  }

  Future<ApiResult<List>> getCartList() async {
    try {
      var response = await _dioClient.getWithClayful('/api/v1/commerce/cart/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<bool>> deleteAllCart() async {
    try {
      var response =
          await _dioClient.deleteWithClayful('/api/v1/commerce/cart/empty/');

      return ApiResult.success(data: true);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<bool>> deleteCart(List body) async {
    try {
      print(body);

      var response = await _dioClient
          .deleteWithClayful('/api/v1/commerce/cart/delete-item/', data: body);

      return ApiResult.success(data: true);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
