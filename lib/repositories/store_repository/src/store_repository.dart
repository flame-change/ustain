import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';

class StoreRepository {
  StoreRepository(this._dioClient);

  final DioClient _dioClient;

  // Future<ApiResult<PageResponse>> getStorePeed(String productId) async {
  //   try {
  //     var response = await _dioClient
  //         .getWithAuth('/api/v1/commerce/product/detail/$productId');
  //
  //     return ApiResult.success(data: Product.fromJson(response));
  //   } catch (e) {
  //     return ApiResult.failure(error: NetworkExceptions.getDioException(e));
  //   }
  // }



}