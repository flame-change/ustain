import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/account/view/finding_password_page.dart';
import 'package:aroundus_app/modules/authentication/signin/view/signin_page.dart';
import 'package:aroundus_app/modules/authentication/signup/models/email.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class FindingPasswordResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindingPasswordResultPageState();
}

class _FindingPasswordResultPageState extends State<FindingPasswordResultPage> {
  late FindingAccountCubit _findingAccountCubit;

  @override
  void initState() {
    super.initState();
    _findingAccountCubit = BlocProvider.of<FindingAccountCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageWire(
        child: BlocListener<FindingAccountCubit, FindingAccountState>(
          listener: (context, state) async {},
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
                  child: Text("변경 완료"),
                  onPressed: () async {
                    bool? a = await _findingAccountCubit.resetPassWord();
                    if (a!) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'login_home_screen', (route) => false);
                    }
                  }),
            ],
          ),
        ),
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
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) {
            context.read<FindingAccountCubit>().passwordChanged(password);
          },
          maxLength: 60,
          obscureText: true,
          decoration: InputDecoration(
            counterText: '',
            labelText: '비밀번호',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
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
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<FindingAccountCubit>()
              .confirmedPasswordChanged(confirmPassword),
          maxLength: 60,
          obscureText: true,
          decoration: InputDecoration(
            counterText: '',
            labelText: '비밀번호 확인',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}
