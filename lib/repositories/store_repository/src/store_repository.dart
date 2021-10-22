import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';

class StoreRepository {
  StoreRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<PageResponse>> getProductsByCollection(Collection collection, String sort, int page) async {
    try {
      String collectionName = collection.Id==null?"":collection.Id+"/";

      var response = await _dioClient
          .getWithAuth('/api/v1/commerce/product/${collectionName}list?page=$page&sort=$sort');

      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List>> getSubCollection(Collection collection) async {
    try {
      var response = await _dioClient.getWithAuth('/api/v1/commerce/collection/${collection.Id}/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}