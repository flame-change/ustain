import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:logger/logger.dart';

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
        return Column(
          children: [
            TextFormField(
              key: Key('finding_account_phoneNumber_code_textFormField'),
              inputFormatters: [
                MaskedInputFormatter('000-0000-0000',
                    allowedCharMatcher: RegExp('[0-9]'))
              ],
              onChanged: (phoneNumber) => context
                  .read<FindingAccountCubit>()
                  .phoneNumberChanged(phoneNumber),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '휴대폰 번호',
              ),
            ),

              // onPressed: state.phoneNumber.valid &&
              //         state.phoneNumberVerifyStatus != VerifyStatus.verified
              //     ? () {
              //         if (state.phoneNumberVerifyStatus != VerifyStatus.init) {
              //           context
              //               .read<FindingAccountCubit>()
              //               .findingPhoneNumberVerifyRequest();
              //           context.read<FindingAccountCubit>().republishAuth();
              //         } else {
              //           context
              //               .read<FindingAccountCubit>()
              //               .findingPhoneNumberVerifyRequest();
              //         }
              //       }
              //     : null,
          ],
        );
      },
    );
  }
}
