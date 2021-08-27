part of 'finding_account_cubit.dart';

class FindingAccountState extends Equatable {
  const FindingAccountState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.phoneNumber = const PhoneNumber.pure(),
    this.phoneNumberVerifyStatus = VerifyStatus.init,
    this.emailVerifyStatus = VerifyStatus.init,
    this.verifyNumber = const VerifyNumber.pure(),
    this.emailVerifyNumber = const VerifyNumber.pure(),

    this.republishFlag = false,
    this.expiredFlag = false,
    this.unverifiedFlag = false,
    this.phoneToken,

    this.errorMessage = "",
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final PhoneNumber phoneNumber;
  final VerifyStatus phoneNumberVerifyStatus;
  final VerifyStatus emailVerifyStatus;
  final VerifyNumber verifyNumber;
  final VerifyNumber emailVerifyNumber;
  final bool republishFlag;
  final bool expiredFlag;
  final bool unverifiedFlag;

  final String? phoneToken;
  final String? errorMessage;

  @override
  List<Object> get props =>
      [
        email,
        password,
        confirmedPassword,
        status,
        phoneNumber,
        phoneNumberVerifyStatus,
        emailVerifyStatus,
        verifyNumber,
        emailVerifyNumber,
        republishFlag,
        expiredFlag,
        unverifiedFlag,
      ];

  FindingAccountState copyWith({Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    PhoneNumber? phoneNumber,
    VerifyStatus? phoneNumberVerifyStatus,
    VerifyStatus? emailVerifyStatus,
    VerifyNumber? verifyNumber,
    VerifyNumber? emailVerifyNumber,
    String? errorMessage,
    bool? republishFlag,
    bool? expiredFlag,
    bool? unverifiedFlag,
    String? phoneToken,

  }) {
    return FindingAccountState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        status: status ?? this.status,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneNumberVerifyStatus: phoneNumberVerifyStatus ?? this.phoneNumberVerifyStatus,
        emailVerifyStatus: emailVerifyStatus ?? this.emailVerifyStatus,
        verifyNumber: verifyNumber ?? this.verifyNumber,
        emailVerifyNumber: emailVerifyNumber ?? this.emailVerifyNumber,
        errorMessage: errorMessage ?? this.errorMessage,
        republishFlag: republishFlag ?? this.republishFlag,
        expiredFlag: expiredFlag ?? this.expiredFlag,
        unverifiedFlag: unverifiedFlag ?? this.unverifiedFlag,
        phoneToken: phoneToken ?? this.phoneToken
    );
  }
}
