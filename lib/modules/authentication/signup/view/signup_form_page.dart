import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:formz/formz.dart';

class SignupForm extends StatefulWidget {
  static String routeName = 'signup_form_page';

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late SignupCubit _signupCubit;

  @override
  void initState() {
    super.initState();
    _signupCubit = BlocProvider.of<SignupCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: mainLogo(), backgroundColor: Colors.black),
        body: BlocListener<SignupCubit, SignupState>(
            listener: (context, state) async {
              // if (state.status.isSubmissionFailure) {
              //   Scaffold.of(context)
              //     ..hideCurrentSnackBar()
              //     ..showSnackBar(
              //       SnackBar(content: Text('${state.errorMessage}')),
              //     );
              // }
              // if (state.isDupCheckedSnsId != null && state.errorMessage != null) {
              //   Scaffold.of(context)
              //     ..hideCurrentSnackBar()
              //     ..showSnackBar(
              //       SnackBar(content: Text('${state.errorMessage}')),
              //     );
              //   context.read<SignupCubit>().errorMessageInit();
              // }
            },
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  padding: basePadding(vertical: Adaptive.h(10)),
                  color: Colors.black,
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                        style: theme.textTheme.headline2!
                            .copyWith(color: Colors.white, height: 1.5),
                        children: [
                          TextSpan(text: "마지막 단계!\n"),
                          TextSpan(text: "조금만 더 힘내세요!"),
                        ]),
                  )),
              Container(
                  color: Colors.black,
                  child: Container(
                      padding: basePadding(vertical: Adaptive.w(5)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25))),
                      child: Wrap(runSpacing: 15, spacing: 5, children: [
                        Text("SIGN UP",
                            style: theme.textTheme.headline2!
                                .copyWith(fontSize: Adaptive.dp(20))),
                        TextFormField(
                          decoration: InputDecoration(labelText: '휴대폰 번호'),
                          readOnly: true,
                          initialValue: _signupCubit.state.phoneNumber.value,
                        ),
                        _PasswordInput(),
                        _ConfirmPasswordInput(),
                        _SignUpButton()
                      ])))
            ]))));
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
              key: const Key('signUpForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<SignupCubit>().passwordChanged(password),
              maxLength: 60,
              obscureText: true,
              decoration: InputDecoration(
                  counterText: '',
                  labelText: '비밀번호',
                  helperText: '',
                  errorText: state.password.invalid
                      ? '영소문자, 특수문자 포함 8글자이상 입력해주세요.'
                      : null));
        });
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
        buildWhen: (previous, current) =>
            previous.password != current.password ||
            previous.confirmedPassword != current.confirmedPassword,
        builder: (context, state) {
          return TextField(
              key: const Key('signUpForm_confirmedPasswordInput_textField'),
              onChanged: (confirmPassword) => context
                  .read<SignupCubit>()
                  .confirmedPasswordChanged(confirmPassword),
              maxLength: 60,
              obscureText: true,
              decoration: InputDecoration(
                  counterText: '',
                  labelText: '비밀번호 확인',
                  helperText: '',
                  errorText: state.confirmedPassword.invalid
                      ? '비밀번호가 일치하지 않습니다.'
                      : null));
        });
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return state.status.isSubmissionInProgress
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : PlainButton(
              onPressed: state.password.valid && state.confirmedPassword.valid
                  ? () => context.read<SignupCubit>().signUpFormSubmitted(state)
                  : null,
              text: '회원가입');
    });
  }
}
