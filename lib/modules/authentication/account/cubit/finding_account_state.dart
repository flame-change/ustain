part of 'finding_account_cubit.dart';

class FindingAccountState extends Equatable {
  const FindingAccountState({
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.phoneNumber = const PhoneNumber.pure(),
    this.phoneNumberVerifyStatus = VerifyStatus.init,
    this.verifyNumber = const VerifyNumber.pure(),

    this.republishFlag = false,
    this.expiredFlag = false,
    this.unverifiedFlag = false,
    this.phoneToken,

    required this.errorMessage,
  });

  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final PhoneNumber phoneNumber;
  final VerifyStatus phoneNumberVerifyStatus;
  final VerifyNumber verifyNumber;
  final bool republishFlag;
  final bool expiredFlag;
  final bool unverifiedFlag;

  final String? phoneToken;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [
        password,
        confirmedPassword,
        status,
        phoneNumber,
        phoneNumberVerifyStatus,
        verifyNumber,
        republishFlag,
        expiredFlag,
        unverifiedFlag,
        phoneToken,
      ];

  FindingAccountState copyWith({
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    PhoneNumber? phoneNumber,
    VerifyStatus? phoneNumberVerifyStatus,
    VerifyNumber? verifyNumber,
    String? errorMessage,
    bool? republishFlag,
    bool? expiredFlag,
    bool? unverifiedFlag,
    String? phoneToken,
  }) {
    return FindingAccountState(
        password: password ?? this.password,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        status: status ?? this.status,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneNumberVerifyStatus: phoneNumberVerifyStatus ?? this.phoneNumberVerifyStatus,
        verifyNumber: verifyNumber ?? this.verifyNumber,
        errorMessage: errorMessage ?? this.errorMessage,
        republishFlag: republishFlag ?? this.republishFlag,
        expiredFlag: expiredFlag ?? this.expiredFlag,
        unverifiedFlag: unverifiedFlag ?? this.unverifiedFlag,
        phoneToken: phoneToken ?? this.phoneToken
    );
  }
}
