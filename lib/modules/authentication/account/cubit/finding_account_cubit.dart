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
    emit(state.copyWith(errorMessage: ""));
  }

  Future<void> findingPhoneNumberVerifyRequest(String phoneNumber) async {
    ApiResult<Map> apiResult =
        await _authenticationRepository.requestFindingPassWordVerifier(
      phoneNumber: phoneNumber.replaceAll("-", ""),
    );
    apiResult.when(success: (Map? response) {
      emit(state.copyWith(phoneNumberVerifyStatus: VerifyStatus.request));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          errorMessage: NetworkExceptions.getErrorMessage(error!),
          phoneNumberVerifyStatus: VerifyStatus.unverified));
    });
  }
}
