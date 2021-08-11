import 'package:formz/formz.dart';

enum NickNameValidationError { invalid }

class NickName extends FormzInput<String, NickNameValidationError> {
  const NickName.pure() : super.pure('');
  const NickName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nickNameRegExp = RegExp(
    r'^[a-zA-Z0-9ㄱ-ㅎ가-힣]{2,25}$',
  );

  @override
  NickNameValidationError? validator(String value) {
    return _nickNameRegExp.hasMatch(value) ? null : NickNameValidationError.invalid;
  }
}
