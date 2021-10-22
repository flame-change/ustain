import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:formz/formz.dart';

class FindingPasswordResultPage extends StatefulWidget {
  static String routeName = 'finding_password_result_page';

  @override
  State<StatefulWidget> createState() => _FindingPasswordResultPageState();
}

class _FindingPasswordResultPageState extends State<FindingPasswordResultPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: mainLogo(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushNamed(context, 'login_home_screen');
          },
        ),
      ),
      body: BlocBuilder<FindingAccountCubit, FindingAccountState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Column(
            children: [
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
                                text: "새 비밀번호",
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
                      Text("NEW PASSWORD",
                          style: theme.textTheme.headline2!
                              .copyWith(fontSize: Adaptive.dp(20))),
                      _PasswordInput(),
                      _ConfirmPasswordInput(),
                      PlainButton(
                          color: state.status == FormzStatus.invalid
                              ? Colors.transparent
                              : null,
                          text: state.status == FormzStatus.invalid
                              ? ""
                              : "변경 완료",
                          onPressed: state.status == FormzStatus.invalid
                              ? null
                              : () async {
                                  await context
                                      .read<FindingAccountCubit>()
                                      .resetPassWord();

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      'login_home_screen', (route) => false);
                                }),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindingAccountCubit, FindingAccountState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          // key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) {
            context.read<FindingAccountCubit>().passwordChanged(password);
          },
          maxLength: 60,
          obscureText: true,
          decoration: InputDecoration(
            counterText: '',
            labelText: '새 비밀번호',
            helperText: '',
            errorText: state.password.invalid
                ? '영어 대소문자, 숫자, 특수문자 모두 포함 최소 8글자 이상 입력'
                : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindingAccountCubit, FindingAccountState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          // key: const Key('signUpForm_conf/**/irmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<FindingAccountCubit>()
              .confirmedPasswordChanged(confirmPassword),
          maxLength: 60,
          obscureText: true,
          decoration: InputDecoration(
            counterText: '',
            labelText: '비밀번호 확인',
            helperText: '',
            errorText:
                state.confirmedPassword.invalid ? '비밀번호를 다시 확인해주세요.' : null,
          ),
        );
      },
    );
  }
}
