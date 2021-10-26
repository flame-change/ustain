import 'package:aroundus_app/repositories/address_repository/models/address.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';

class AddressRepository {
  AddressRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<List>> getAddressList() async {
    try {
      var response = await _dioClient.getWithClayful('/api/v1/commerce/customer/address/list/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Address>> createAddress(Address newAddress) async {
    try {
      var response = await _dioClient.postWithClayful('/api/v1/commerce/customer/address/create/', data: newAddress);

      return ApiResult.success(data: Address.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<dynamic>> deleteAddress(int addressId) async {
    try {
      var response = await _dioClient.delete('/api/v1/commerce/customer/address/delete/', data: {"id" : addressId});

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<dynamic>> updateDefaultAddress(int addressId) async {
    try {
      var response = await _dioClient.patch('/api/v1/commerce/customer/address/$addressId/', data: {"isDefault" : true});

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
