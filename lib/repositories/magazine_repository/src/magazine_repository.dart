import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';

class MagazineRepository {
  MagazineRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<List>> getMainMagazine() async {
    try {
      var response =
          await _dioClient.getWithAuth('/api/v1/magazine/list/is-main/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<PageResponse>> getMagazinesByCategory(
      String categoriesList) async {
    try {
      var response = await _dioClient.get('/api/v1/magazine/list/?page=1&categories=[$categoriesList]');
      
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
