import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authenticationRepository) : super(const SignInState());

  final AuthenticationRepository _authenticationRepository;
  var logger = Logger(printer: PrettyPrinter());

  Future<void> signIn({required String phoneNumber, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiResult<Map> apiResult = await _authenticationRepository.signIn(
        phoneNumber: phoneNumber, password: password);

    apiResult.when(
        success: (Map? response) {
          logger.d("prefs ${prefs.get('access')}");
          prefs.setString('access', response!['access']);
          prefs.setString('clayful', response['clayful']);
          prefs.setString('refresh', response['refresh']);
          _authenticationRepository.logIn();
          emit(state.copyWith(
            auth: true,
          ));
        },
        failure: (NetworkExceptions? error) {
          emit(state.copyWith(
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error!),
          ));
        });
  }

  void errorMsg(){
    emit(state.copyWith(
      errorMessage: ""
    ));
  }
}
