import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';

class UserGetFailure implements Exception {}

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  Future<ApiResult<User>> getUser() async {
    try {
      var response = await _dioClient.getWithAuth('/api/v1/user/profile/');

      return ApiResult.success(data: User(
        groups: response['groups'],
        phone: response['phone'],
        email: response['email'],
        name: response['name'],
        profileArticle: response['profileArticle'],
        sexChoices: response['sexChoices'],
        birthday: response['birthday'],
        categories: response['categories'],
      ),
      );
    } on Exception {
      throw UserGetFailure();
    }
  }
}
