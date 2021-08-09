import 'dart:async';

import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/modules/authentication/signup/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    cancelTimer();
    super.dispose();
  }

  void startTimer() {
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      if (seconds! < 1) {
        cancelTimer();
        setState(() {
          seconds = 0;
        });
      } else {
        setState(() {
          seconds = seconds! - 1;
        });
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      _signupCubit!.phoneNumberVerifyExpired();
    }
  }

  VerifyStatus verifyStatus = VerifyStatus.init;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.verifyNumber != current.verifyNumber ||
          previous.phoneNumberVerifyStatus != current.phoneNumberVerifyStatus,
      builder: (context, state) {
        if (state.phoneNumberVerifyStatus != verifyStatus) {
          verifyStatus = state.phoneNumberVerifyStatus;
          if (verifyStatus == VerifyStatus.request) {
            //요청을 줬을 때 타이머 재시작 로직

            var date = DateTime.now().add(Duration(minutes: 3));
            var now = DateTime.now();
            var twoHours = date.difference(now);
            if (twoHours.inSeconds > 0) {
              seconds = twoHours.inSeconds;
              startTimer();
            } else {
              seconds = 0;
            }
          } else if (verifyStatus == VerifyStatus.verified) {
            _timer!.cancel();
            _timer = null;
          }
        }
        return Column(
          children: [
            TextField(
              enabled: verifyStatus != VerifyStatus.verified,
              key: const Key('signUpForm_verifyNumber_textField'),
              onChanged: (verifyNumber) =>
                  _signupCubit!.verifyNumberChanged(verifyNumber),
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                labelText: '인증번호',
                errorText: state.verifyNumber.invalid ? '숫자만 입력 가능합니다.' : null,
                suffixIcon: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text('$seconds'),
                        ),
                      ),
                    ],
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                  minHeight: 32,
                  minWidth: 32,
                  maxWidth: 200,
                ),
              ),
            ),
            FlatButton(
              color: Colors.grey,
              onPressed: state.verifyNumber.valid &&
                      (verifyStatus == VerifyStatus.request ||
                          verifyStatus == VerifyStatus.unverified)
                  ? () => _signupCubit!.phoneNumberVerify()
                  : null,
              child: verifyStatus == VerifyStatus.expiered
                  ? Text('시간만료')
                  : verifyStatus == VerifyStatus.verified
                      ? Text('인증성공')
                      : Text('번호인증'),
              textColor: Colors.white,
            ),
          ],
        );
      },
    );
  }
}
