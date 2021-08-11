import 'package:formz/formz.dart';

enum VerifyNumberValidationError { invalid }

class VerifyNumber extends FormzInput<String, VerifyNumberValidationError> {
  const VerifyNumber.pure() : super.pure('');

  const VerifyNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _verifyNumberRegExp = RegExp(
    r'^[0-9]{3,10}$',
  );

  @override
  VerifyNumberValidationError? validator(String value) {
    return _verifyNumberRegExp.hasMatch(value)
        ? null
        : VerifyNumberValidationError.invalid;
  }
}
