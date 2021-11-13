import 'dart:async';

import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/support/base_component/plain_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class VerifyNumberInput extends StatefulWidget {
  @override
  _VerifyNumberInputState createState() => _VerifyNumberInputState();
}

class _VerifyNumberInputState extends State<VerifyNumberInput> {
  Timer? _timer;
  int? seconds;

  SignupCubit? _signupCubit;

  @override
  void initState() {
    super.initState();
    _signupCubit = BlocProvider.of<SignupCubit>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  VerifyStatus verifyStatus = VerifyStatus.init;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.verifyNumber != current.verifyNumber ||
          previous.phoneNumberVerifyStatus != current.phoneNumberVerifyStatus,
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              enabled: verifyStatus != VerifyStatus.verified,
              key: const Key('signUpForm_verifyNumber_textField'),
              onChanged: (verifyNumber) =>
                  _signupCubit!.verifyNumberChanged(verifyNumber),
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                labelText: '인증번호',
                errorText: state.verifyNumber.invalid ? '숫자만 입력 가능합니다.' : null,
                suffixIconConstraints: BoxConstraints(
                  minHeight: 32,
                  minWidth: 32,
                  maxWidth: 200,
                ),
              ),
            ),
            PlainButton(
              onPressed:
                      (state.phoneNumberVerifyStatus == VerifyStatus.request ||
                          state.phoneNumberVerifyStatus == VerifyStatus.unverified)
                  ? () => _signupCubit!.phoneNumberVerify()
                  : null,
              text: verifyStatus == VerifyStatus.complete
                      ? "인증성공"
                      : "인증완료",
            )
          ],
        );
      },
    );
  }
}
