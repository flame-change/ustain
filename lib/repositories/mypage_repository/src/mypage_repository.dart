import 'package:aroundus_app/repositories/mypage_repository/models/mypage.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';

class MypageRepository {
  MypageRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<Mypage>> getMyPageInfo() async {
    try {
      var response = await _dioClient.getWithAuth('/api/v1/mypage/info/user/');
      return ApiResult.success(data: Mypage.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> updateMypageInfo(updateInfo) async {
    try {
      var response = await _dioClient.postWithAuth('/api/v1/mypage/info/user/',
          data: updateInfo);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
