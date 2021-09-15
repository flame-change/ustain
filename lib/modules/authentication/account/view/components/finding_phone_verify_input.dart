import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';


var logger = Logger(printer: PrettyPrinter());

class FindingPhoneNumberInputField extends StatelessWidget {
  String _updatePhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindingAccountCubit, FindingAccountState>(
      buildWhen: (pre, cur) =>
      pre.phoneNumber != cur.phoneNumber ||
          pre.phoneNumberVerifyStatus != cur.phoneNumberVerifyStatus,
      builder: (context, state) {
        return TextFormField(
          key: Key('finding_account_phoneNumber_code_textFormField'),
          inputFormatters: [
            MaskedInputFormatter('000-0000-0000', allowedCharMatcher: RegExp('[0-9]'))
          ],
          onChanged: (phoneNumber) =>
              context.read<FindingAccountCubit>().phoneNumberChanged(phoneNumber),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: '전화번호',
              errorText: state.phoneNumber.invalid ? '숫자만 입력 가능합니다.' : null,
              suffixIcon: Container(
                padding: EdgeInsets.only(right: 10),
                child: MaterialButton(
                  color: Colors.grey,
                  onPressed: state.phoneNumber.valid &&
                      state.phoneNumberVerifyStatus != VerifyStatus.verified
                      ? () {
                    if (state.phoneNumberVerifyStatus !=
                        VerifyStatus.init) {
                      context
                          .read<FindingAccountCubit>()
                          .findingPhoneNumberVerifyRequest();
                      context.read<FindingAccountCubit>().republishAuth();
                    } else {
                      context
                          .read<FindingAccountCubit>()
                          .findingPhoneNumberVerifyRequest();
                    }
                  }
                      : null,
                  child: state.phoneNumberVerifyStatus != VerifyStatus.init
                      ? Text(
                    '인증 재발급',
                  )
                      : Text(
                    '인증요청',
                  ),
                  textColor: Colors.white,
                ),
              )),
        );
      },
    );
  }
}
