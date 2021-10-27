import 'package:aroundus_app/repositories/coupon_repository/models/coupon.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';

class CouponRepository {
  CouponRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<List>> getCouponList() async {
    try {
      var response = await _dioClient.getWithClayful('/api/v1/commerce/coupon/list/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}