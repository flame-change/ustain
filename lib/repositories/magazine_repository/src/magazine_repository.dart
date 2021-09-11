import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
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
      int page,
      String categoriesList) async {
    try {
      var response = await _dioClient.get('/api/v1/magazine/list/?page=$page&categories=[$categoriesList]');
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<MagazineDetail>> getMagazineDetail(int id) async {
    try {
      var response =
          await _dioClient.getWithAuth('/api/v1/magazine/detail/$id');
      return ApiResult.success(data: MagazineDetail.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> getIsLike(int id) async {
    try {
      var response = await _dioClient
          .getWithAuth('/api/v1/magazine/detail/$id/update-like/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> updateLike(int id) async {
    try {
      var response =
          await _dioClient.put('/api/v1/magazine/detail/$id/update-like/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> updateScrapped(int id) async {
    try {
      var response =
      await _dioClient.put('/api/v1/magazine/detail/$id/update-scrap/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<PageResponse>> getMagazineComments(int id) async {
    try {
      // TODO Page 처리
      var response = await _dioClient
          .getWithAuth('/api/v1/magazine/detail/$id/reviews/?page=1');
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> requestMagazineComment(Map<String, dynamic> body) async {
    try {
      var response = await _dioClient.postWithAuth('/api/v1/magazine/detail/reviews/review-create/', data: body);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> deleteMagazineComment(int commentId) async {
    try {
      var response = await _dioClient.delete('/api/v1/magazine/detail/$commentId/review/delete/');

      return ApiResult.success(data: null);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> updateMagazineComment(int commentId, String content) async {
    try {
      Map<String, dynamic> body = {
        "content": content
      };

      var response = await _dioClient.put('/api/v1/magazine/detail/$commentId/review/update/', data: body);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<PageResponse>> getScrappedMagazine(int page) async {
    try {
      var response = await _dioClient.getWithAuth('/api/v1/magazine/list/scrapped/?page=$page');
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
