import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';

class ProductRepository {
  ProductRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<Product>> getProductDetail(String productId) async {
    try {
      var response = await _dioClient
          .getWithAuth('/api/v1/commerce/product/detail/$productId');

      return ApiResult.success(data: Product.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> createCard(Map body) async {
    try {
      var response =
          await _dioClient.postWithClayful('/api/v1/commerce/cart/add/', data: body);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
