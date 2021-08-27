import 'dart:async';
import 'dart:convert';

import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final DioClient _dioClient;

  AuthenticationRepository(this._dioClient);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    String? accessToken = await getAccessToken();
    logger.d("Stream<AuthenticationStatus> get status");

    if (accessToken != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<void> logIn() async {
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("access");
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  Future<ApiResult<Map>> requestPhoneVerifier({
    required String phoneNumber,
  }) async {
    try {
      String body = json.encode({"phone": phoneNumber});
      var response =
          await _dioClient.post('/api/v1/user/phone-verifier/', data: body);
      return ApiResult.success(
        data: response['phone'],
      );
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<String>> confirmVerifierCode(
      {required String phoneNumber, required String code}) async {
    try {
      String body = json.encode({"phone": phoneNumber, "code": code});

      var response = await _dioClient
          .post('/api/v1/user/phone-verifier/confirm/', data: body);
      return ApiResult.success(
        data: response['phoneToken'],
      );
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<String>> verifyCode({
    required String phoneNumber,
    required String verifyCode,
  }) async {
    try {
      String body = json.encode({
        "phone": phoneNumber,
        "code": verifyCode,
      });
      var response = await _dioClient
          .post('/api/v1/user/phone-verifier/confirm/', data: body);
      return ApiResult.success(
        data: response['phoneToken'],
      );
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<String>> emailVerifyRequest({
    required String email,
  }) async {
    try {
      String body = json.encode({"email": email});
      var response =
          await _dioClient.post('/api/v1/user/email-verifier/', data: body);
      return ApiResult.success(
        data: response['email'],
      );
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<String>> emailAuthCheck(
      {required String email, required String password}) async {
    try {
      String body = json.encode({"email": email});
      return ApiResult.success(
        data: email,
      );
    } catch (e) {
      print(e);
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> signUp(
      {required String email,
      required String password,
      required String phone,
      required String phoneToken,
      required String passwordConfirm}) async {
    try {
      String body = json.encode({
        "email": email,
        "phone": phone,
        "password": password,
        "phoneToken": phoneToken,
        "passwordConfirm": passwordConfirm
      });

      var response =
          await _dioClient.post('/api/v1/user/register/', data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> signIn(
      {required String email, required String password}) async {
    try {
      String body = json.encode({
        "email": email,
        "password": password,
      });

      logger.d(body);

      var response = await _dioClient.post('/api/v1/user/login/', data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<String?> getAccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('access');
    } on Exception {
      logger.d(Error);
    }
  }
}
