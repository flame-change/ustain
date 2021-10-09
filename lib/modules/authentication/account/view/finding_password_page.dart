import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/account/view/view.dart';
import 'package:aroundus_app/modules/authentication/signup/signup.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class FindingPasswordPage extends StatefulWidget {
  static String routeName = 'finding_password_page';

  @override
  State<StatefulWidget> createState() => _FindingPasswordPageState();
}

class _FindingPasswordPageState extends State<FindingPasswordPage> {
  late FindingAccountCubit _findingAccountCubit;
  VerifyStatus phoneNumberVerifyStatus = VerifyStatus.init;

  @override
  void initState() {
    super.initState();
    _findingAccountCubit = BlocProvider.of<FindingAccountCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: mainLogo(),
        ),
        body: BlocListener<FindingAccountCubit, FindingAccountState>(
          bloc: _findingAccountCubit,
          listener: (context, state) async {
            if (state.phoneNumberVerifyStatus == VerifyStatus.request) {
              if (state.phoneNumberVerifyStatus != phoneNumberVerifyStatus) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('인증번호가 발급되었습니다.')),
                  );
              } else if (state.republishFlag) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('인증번호가 재발급되었습니다.')),
                  );
              }
              setState(() {
                phoneNumberVerifyStatus = state.phoneNumberVerifyStatus;
                _findingAccountCubit.republishAuthInit();
              });
            }
            if (state.phoneNumberVerifyStatus == VerifyStatus.expiered &&
                state.expiredFlag) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('인증번호 입력시간이 만료되었습니다.')),
                );
              setState(() {
                _findingAccountCubit.expiredFlagFalse();
              });
            }
            if (state.phoneNumberVerifyStatus == VerifyStatus.unverified &&
                state.unverifiedFlag) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('인증번호가 일치하지 않습니다.')),
                );
              setState(() {
                _findingAccountCubit.unverifiedFlagFalse();
              });
            }
          },
          child: Column(children: [
            Flexible(
              flex: 3,
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: basePadding(),
                  child: RichText(
                    text: TextSpan(
                        style: theme.textTheme.headline2!
                            .copyWith(color: Colors.white, height: 1.5),
                        children: [
                          TextSpan(
                              text: "인증번호",
                              style: theme.textTheme.headline2!
                                  .copyWith(color: theme.accentColor)),
                          TextSpan(text: "를\n"),
                          TextSpan(text: "입력 해 주세요!"),
                        ]),
                  )),
            ),
            Flexible(
              flex: 6,
              child: Container(
                padding: basePadding(vertical: Adaptive.h(4)),
                height: Adaptive.h(100),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25))),
                child: Wrap(
                  runSpacing: 15,
                  children: [
                    Text("FIND PASSWORD",
                        style: theme.textTheme.headline2!
                            .copyWith(fontSize: Adaptive.dp(20))),
                    TextFormField(
                      key:
                      Key('finding_account_phoneNumber_code_textFormField'),
                      inputFormatters: [
                        MaskedInputFormatter('000-0000-0000',
                            allowedCharMatcher: RegExp('[0-9]'))
                      ],
                      onChanged: (phoneNumber) =>
                          context
                              .read<FindingAccountCubit>()
                              .phoneNumberChanged(phoneNumber),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '휴대폰 번호',
                      ),
                    ),
                    PlainButton(
                      text: "인증번호 전송",
                      onPressed: () {
                        _findingAccountCubit
                            .findingPhoneNumberVerifyRequest()
                            .whenComplete(() {
                              Future.delayed(Duration(seconds: 3));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                BlocProvider<FindingAccountCubit>.value(
                                  value: _findingAccountCubit,
                                  child: FindingPasswordRequestPage(),
                                ),
                              ));
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
