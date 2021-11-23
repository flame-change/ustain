import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/modules/authentication/signup/models/models.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'finding_account_state.dart';

class FindingAccountCubit extends Cubit<FindingAccountState> {
  FindingAccountCubit(this._authenticationRepository)
      : super(const FindingAccountState());

  final AuthenticationRepository _authenticationRepository;

  void errorMsg() {
    emit(state.copyWith(
        errorMessage: ""
    ));
  }

  Future<void> findingPhoneNumberVerifyRequest() async {
    if (!state.phoneNumber.valid) return;
    // emit(state.copyWith(phoneNumberVerifyStatus: VerifyStatus.request));
    ApiResult<Map> apiResult = await _authenticationRepository.requestFindingPassWordVerifier(
      phoneNumber: state.phoneNumber.value.replaceAll("-", ""),
    );
    apiResult.when(success: (Map? response) {
      emit(state.copyWith(phoneNumberVerifyStatus: VerifyStatus.request));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        errorMessage: NetworkExceptions.getErrorMessage(error!),
        phoneNumberVerifyStatus: VerifyStatus.unverified
      ));
    });
  }

  Future<bool?> findingPassWordVerify() async {
    if (!state.phoneNumber.valid) return false;
    ApiResult<String> apiResult =
    await _authenticationRepository.findingPassWordVerifyCode(
      phoneNumber: state.phoneNumber.value.replaceAll("-", ""),
      verifyCode: state.verifyNumber.value,
    );
    apiResult.when(success: (String? phoneToken) {
      emit(state.copyWith(
          phoneNumberVerifyStatus: VerifyStatus.verified,
          phoneToken: phoneToken!));
      return true;
    }, failure: (NetworkExceptions? error) {
      logger.w(error);
      emit(state.copyWith(
        errorMessage: NetworkExceptions.getErrorMessage(error!),
          phoneNumberVerifyStatus: VerifyStatus.unverified,
          unverifiedFlag: true));
      return false;
    });
  }

  Future<void> resetPassWord() async {
    // if (!state.password.valid || !state.confirmedPassword.valid) return;

    print(state);
    ApiResult<String> apiResult = await _authenticationRepository.resetPassWord(
      phoneNumber: state.phoneNumber.value.replaceAll("-", ""),
      phoneToken: state.phoneToken!,
      password: state.password.value,
      passwordConfirm: state.confirmedPassword.value,
    );

    apiResult.when(success: (String? phone) {
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  void passwordChanged(String value) {
    Password newPassword = Password.dirty(value);


    print(newPassword);

    emit(state.copyWith(
        password: newPassword
    ));
  }

  void confirmedPasswordChanged(String value) {
    print(value);

    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.password,
        confirmedPassword,
      ]),
    ));
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
        state.password,
        phoneNumber,
      ]),
      phoneNumberVerifyStatus: null,
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      status: Formz.validate([
        email,
      ]),
    ));
  }

  void completeVerify(){
    emit(state.copyWith(
      phoneNumberVerifyStatus: VerifyStatus.complete
    ));
  }
}
