import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/modules/authentication/signup/view/view.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        appBar: AppBar(),
        body: PageWire(
          child: BlocListener<SignupCubit, SignupState>(
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
            child: Column(
              children: [
                Text("안녕하세요☺️ 어쩌구 저쩌구"),
                // _EmailInput(),
                TextFormField(
                  readOnly: true,
                  initialValue: _signupCubit.state.phoneNumber.value,
                ),
                _PasswordInput(),
                _ConfirmPasswordInput(),
                _SignUpButton(),
              ],
            ),
          ),
        ));
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
            errorText: state.password.invalid ? '영소문자, 특수문자 포함 8글자이상 입력해주세요.' : null,
          ),
        );
      },
    );
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
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? Center(
                child: const CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: FlatButton(
                  disabledColor: Colors.grey,
                  padding: EdgeInsets.all(15),
                  color: Colors.amber,
                  key: Key('signUpForm_continue_raisedButton'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text('확인'),
                  onPressed: state.confirmedPassword.valid &&
                          state.password.valid
                      ? () =>
                          context.read<SignupCubit>().signUpFormSubmitted(state)
                      : null,
                ),
              );
      },
    );
  }
}
