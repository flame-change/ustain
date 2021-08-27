
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/modules/authentication/signup/models/models.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'finding_account_state.dart';

class FindingAccountCubit extends Cubit<FindingAccountState> {
  FindingAccountCubit(this._authenticationRepository) : super(const FindingAccountState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> findingEmailPhoneNumberVerifyRequest() async {
    if (!state.phoneNumber.valid) return;
    emit(state.copyWith(phoneNumberVerifyStatus: VerifyStatus.request));
    ApiResult<Map> apiResult = await _authenticationRepository
        .requestFindingEmailPhoneVerifier(
      phoneNumber: state.phoneNumber.value,
    );
    apiResult.when(success: (Map? response) {
      emit(state.copyWith(phoneNumberVerifyStatus: VerifyStatus.request));
    }, failure: (NetworkExceptions? error) {
      if(error!=null) {
        emit(state.copyWith(
            errorMessage: NetworkExceptions.getErrorMessage(
                NetworkExceptions.defaultError('phone-already-in-use'))));
      }
    });
  }

  Future<void> findingEmailPhoneNumberVerify() async {
    if (!state.phoneNumber.valid) return;
    ApiResult<String> apiResult = await _authenticationRepository.findingEmailVerifyCode(
      phoneNumber: state.phoneNumber.value,
      verifyCode: state.verifyNumber.value,
    );
    apiResult.when(success: (String? email) {
      emit(state.copyWith(
          phoneNumberVerifyStatus: VerifyStatus.verified, email: Email.dirty(email!)));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(phoneNumberVerifyStatus: VerifyStatus.unverified,
          unverifiedFlag: true,
          errorMessage: error.toString()));
    });
  }

  void verifyNumberChanged(String value) {
    final verifyNumber = VerifyNumber.dirty(value);
    emit(state.copyWith(
      verifyNumber: verifyNumber,
    ));
  }

  void republishAuth() {
    emit(state.copyWith(republishFlag: true));
  }

  void republishAuthInit() {
    emit(state.copyWith(republishFlag: false));
  }

  void expiredFlagFalse() {
    emit(state.copyWith(expiredFlag: false));
  }

  void unverifiedFlagFalse() {
    emit(state.copyWith(unverifiedFlag: false));
  }

  void phoneNumberVerifyExpired() async {
    emit(state.copyWith(
        phoneNumberVerifyStatus: VerifyStatus.expiered, expiredFlag: true));
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([
        state.email,
        state.password,
        phoneNumber,
      ]),
      phoneNumberVerifyStatus: null,
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
      ]),
    ));
  }

  Future<void> findingPasswordEmailVerifyRequest() async {
    if (!state.email.valid) return;

    emit(state.copyWith(emailVerifyStatus: VerifyStatus.request));

    ApiResult<Map> apiResult = await _authenticationRepository.requestFindingPasswordVerifier(email: state.email.value,);

    apiResult.when(success: (Map? response) {
      emit(state.copyWith(emailVerifyStatus: VerifyStatus.request));
    }, failure: (NetworkExceptions? error) {
      if(error!=null) {
        emit(state.copyWith(
            errorMessage: NetworkExceptions.getErrorMessage(
                NetworkExceptions.defaultError('email-already-in-use'))));
      }
    });
  }
}