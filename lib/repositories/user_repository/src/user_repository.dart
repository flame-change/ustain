import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';

class UserGetFailure implements Exception {}

class CategoryGetFailure implements Exception {}

class CollectionGetFailure implements Exception {}

class CountGetFailure implements Exception {}

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

  Future<List> getCollection() async {
    try {
      var response =
          await _dioClient.getWithAuth('/api/v1/commerce/collection/');

      return response;
    } on Exception {
      throw CollectionGetFailure();
    }
  }

  Future<int> getCartCount() async {
    try {
      var response =
          await _dioClient.getWithClayful('/api/v1/commerce/cart/count-items/');

      return response;
    } on Exception {
      throw CountGetFailure();
    }
  }

  Future<ApiResult<User>> getUser() async {
    List? category = await getCategories();
    List? collections = await getCollection();
    int? cartCount = await getCartCount();

    try {
      var response = await _dioClient.getWithAuth('/api/v1/user/profile/');

      return ApiResult.success(
        data: User(
          groups: response['groups'],
          phone: response['phone'],
          email: response['email'],
          name: response['name'],
          profileArticle: response['profileArticle'],
          sexChoices: response['sexChoices'],
          birthday: response['birthday'],
          selectedCategories: response['categories'],
          categories:
              category.map((e) => MagazineCategory.fromJson(e)).toList(),
          collections: collections.map((e) => Collection.fromJson(e)).toList() +
              [Collection("", "전체보기")],
          cartCount: cartCount,
        ),
      );
    } on Exception {
      throw UserGetFailure();
    }
  }
}
