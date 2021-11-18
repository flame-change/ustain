import 'package:aroundus_app/repositories/brand_repository/models/brand_detail.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';

class BrandRepository {
  BrandRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<PageResponse>> getBrandList(int page) async {
    try {
      var response = await _dioClient
          .get('/api/v1/commerce/brand/brands/list/?page=${page}');
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> getBrand(String brandId) async {
    try {
      var response = await _dioClient.get('/api/v1/commerce/brand/${brandId}/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
