import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/account/view/finding_password_page.dart';
import 'package:aroundus_app/modules/authentication/signin/view/signin_page.dart';
import 'package:aroundus_app/modules/authentication/signup/models/email.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sizer/sizer.dart';

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
      appBar: AppBar(
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
          return PageWire(
            child: Wrap(
              runSpacing: 15,
              children: [
                Text(
                  "새 비밀번호를 입력해주세요.",
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                ),
                _PasswordInput(),
                _ConfirmPasswordInput(),
                MaterialButton(
                    minWidth: 100.w,
                    color: Colors.grey,
                    child: Text("로그인 하러가기"),
                    onPressed: state.status ==
                        FormzStatus.invalid
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
            labelText: '비밀번호',
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
