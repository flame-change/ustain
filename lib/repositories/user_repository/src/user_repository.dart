import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';

class UserGetFailure implements Exception {}

class CategoryGetFailure implements Exception {}

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  Future<List> getCategories() async {
    try {
      var response = await _dioClient.get('/api/v1/user/categories/');
      return response;
    } on Exception {
      throw CategoryGetFailure();
    }
  }

  Future<ApiResult<User>> getUser() async {
    List? category = await getCategories();

    try {
      var response = await _dioClient.getWithAuth('/api/v1/user/profile/');

      return ApiResult.success(
          data: User(
        phone: response['phone'],
        email: response['email'],
        name: response['name'],
        profileArticle: response['profileArticle'],
        sexChoices: response['sexChoices'],
        birthday: response['birthday'],
        selectedCategories: response['categories'],
        categories: category.map((e) => MagazineCategory.fromJson(e)).toList(),
      ));
    } on Exception {
      throw UserGetFailure();
    }
  }

  Future<ApiResult<User>> getUnknownUser() async {
    List? category = await getCategories();

    try {
      var response = await _dioClient.get('/api/v1/user/unknown/profile/');

      return ApiResult.success(
          data: User(
        phone: response['phone'],
        email: response['email'],
        name: response['name'],
        profileArticle: response['profileArticle'],
        sexChoices: response['sexChoices'],
        birthday: response['birthday'],
        selectedCategories: response['categories'],
        categories: category.map((e) => MagazineCategory.fromJson(e)).toList(),
      ));
    } on Exception {
      throw UserGetFailure();
    }
  }
}
