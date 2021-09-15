import 'dart:async';

import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/account/view/finding_password_result_page.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class FindingVerifyNumberInput extends StatefulWidget {
  @override
  _FindingVerifyNumberInputState createState() =>
      _FindingVerifyNumberInputState();
}

class _FindingVerifyNumberInputState extends State<FindingVerifyNumberInput> {
  Timer? _timer;
  int? seconds;

  FindingAccountCubit? _findingAccountCubit;

  @override
  void initState() {
    super.initState();
    _findingAccountCubit = BlocProvider.of<FindingAccountCubit>(context);
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
    if (_timer != null &&
        _findingAccountCubit!.state.phoneNumberVerifyStatus !=
            VerifyStatus.unverified) {
      _timer!.cancel();
      _timer = null;
      _findingAccountCubit!.phoneNumberVerifyExpired();
    }
  }

  VerifyStatus verifyStatus = VerifyStatus.init;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindingAccountCubit, FindingAccountState>(
      listener: (context, state) {
        if(state.phoneNumberVerifyStatus == VerifyStatus.verified){
          _findingAccountCubit!.completeVerify();

          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) =>
                BlocProvider<FindingAccountCubit>.value(
                  value: _findingAccountCubit!,
                  child: FindingPasswordResultPage(),
                )),
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.verifyNumber != current.verifyNumber ||
          previous.phoneNumberVerifyStatus != current.phoneNumberVerifyStatus &&
              current.phoneNumberVerifyStatus != VerifyStatus.verified ,
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
          } else {
            cancelTimer();
          }
        }

        return Column(
          children: [
            TextField(
              enabled: verifyStatus != VerifyStatus.verified,
              onChanged: (verifyNumber) =>
                  _findingAccountCubit!.verifyNumberChanged(verifyNumber),
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
            MaterialButton(
              minWidth: 100.w,
              color: Colors.grey,
              onPressed: state.verifyNumber.valid &&
                      (verifyStatus == VerifyStatus.request ||
                          verifyStatus == VerifyStatus.unverified)
                  ? () async {
                      await _findingAccountCubit!.findingPassWordVerify();
                    }
                  : null,
              // onPressed: state.verifyNumber.valid &&
              //     (verifyStatus == VerifyStatus.request ||
              //         verifyStatus == VerifyStatus.unverified)
              //     ? () => _findingAccountCubit!.findingPassWordVerify()
              //     : null,
              child: verifyStatus == VerifyStatus.expiered
                  ? Text('시간만료')
                  // : verifyStatus == VerifyStatus.verified
                  //     ? Text('인증성공')
                  : Text('번호인증'),
              textColor: Colors.white,
            ),
          ],
        );
      },
    );
  }
}
