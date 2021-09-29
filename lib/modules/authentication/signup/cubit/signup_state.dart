part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignupState extends Equatable {
  const SignupState({
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.nickName = const NickName.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.certString,
    this.agreeService = false,
    this.agreeSecurity = false,
    this.agreeMarketing = false,
    this.isDupCheckedSnsId,
    this.isDupCheckedNickName,
    required this.errorMessage,
    this.phoneNumberVerifyStatus = VerifyStatus.init,
    this.verifyNumber = const VerifyNumber.pure(),
    this.success = false,
    this.republishFlag = false,
    this.expiredFlag = false,
    this.unverifiedFlag = false,
    this.phoneToken,
    this.categories,
  });

  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final NickName nickName;
  final PhoneNumber phoneNumber;
  final String? certString;
  final bool agreeService;
  final bool agreeSecurity;
  final bool agreeMarketing;
  final bool? isDupCheckedSnsId;
  final bool? isDupCheckedNickName;
  final String? errorMessage;
  final VerifyStatus phoneNumberVerifyStatus;
  final VerifyNumber verifyNumber;
  final bool success;
  final bool republishFlag;
  final bool expiredFlag;
  final bool unverifiedFlag;

  final String? phoneToken;
  final List<dynamic>? categories;

  @override
  List<Object?> get props => [
        password,
        confirmedPassword,
        status,
        nickName,
        phoneNumber,
        certString,
        agreeService,
        agreeSecurity,
        agreeMarketing,
        isDupCheckedSnsId,
        isDupCheckedNickName,
        errorMessage,
        phoneNumberVerifyStatus,
        verifyNumber,
        success,
        republishFlag,
        expiredFlag,
        unverifiedFlag,
      ];

  SignupState copyWith({
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    NickName? nickName,
    PhoneNumber? phoneNumber,
    bool? agreeService,
    bool? agreeSecurity,
    bool? agreeMarketing,
    bool? isDupCheckedSnsId,
    bool? isDupCheckedNickName,
    String? errorMessage,
    VerifyStatus? phoneNumberVerifyStatus,
    VerifyNumber? verifyNumber,
    bool? success,
    bool? republishFlag,
    bool? expiredFlag,
    bool? unverifiedFlag,
    String? phoneToken,
    List<dynamic>? categories,
  }) {
    return SignupState(
        password: password ?? this.password,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        status: status ?? this.status,
        nickName: nickName ?? this.nickName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        agreeService: agreeService ?? this.agreeService,
        agreeSecurity: agreeSecurity ?? this.agreeSecurity,
        agreeMarketing: agreeMarketing ?? this.agreeMarketing,
        isDupCheckedSnsId: isDupCheckedSnsId ?? this.isDupCheckedSnsId,
        isDupCheckedNickName: isDupCheckedNickName ?? this.isDupCheckedNickName,
        errorMessage: errorMessage ?? this.errorMessage,
        phoneNumberVerifyStatus:
            phoneNumberVerifyStatus ?? this.phoneNumberVerifyStatus,
        verifyNumber: verifyNumber ?? this.verifyNumber,
        success: success ?? this.success,
        republishFlag: republishFlag ?? this.republishFlag,
        expiredFlag: expiredFlag ?? this.expiredFlag,
        unverifiedFlag: unverifiedFlag ?? this.unverifiedFlag,
        phoneToken: phoneToken ?? this.phoneToken,
        categories: categories ?? this.categories);
  }
}

enum VerifyStatus { init, request, verified, unverified, expiered, complete }
