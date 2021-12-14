import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:formz/formz.dart';

class SignupForm extends StatefulWidget {
  static String routeName = '/signup_form_page';

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late SignupCubit _signupCubit;
  bool _isAdult = false;
  bool _agreeUsage = false;
  bool _personalInfo = false;
  bool _agreeAll = false;

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
                      padding: basePadding(vertical: sizeWidth(5)),
                      color: Colors.white,
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
                        _agreementWidget(context),
                        signupButton()
                      ])))
            ]))));
  }

  BlocBuilder<SignupCubit, SignupState> signupButton() {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return state.status.isSubmissionInProgress
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : PlainButton(
              onPressed: state.password.valid &&
                      state.confirmedPassword.valid &&
                      _isAdult == true &&
                      _personalInfo == true &&
                      _agreeUsage == true
                  ? () => context.read<SignupCubit>().signUpFormSubmitted(state)
                  : null,
              text: '회원가입');
    });
  }

  Container _agreementWidget(BuildContext context) {
    return Container(
        color: Colors.grey.shade100,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
              child: CheckboxListTile(
                  value: _agreeAll,
                  title: Row(children: [
                    Spacer(),
                    Text('전체 동의', style: TextStyle(fontSize: Adaptive.dp(12)))
                  ]),
                  secondary: Text('약관 동의',
                      style: Theme.of(context).textTheme.headline6),
                  onChanged: (value) => setState(() {
                        _agreeAll = value!;
                        _isAdult = value;
                        _agreeUsage = value;
                        _personalInfo = value;
                      }))),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100),
                  color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: sizeWidth(2)),
              child: Column(children: [
                CheckboxListTile(
                    value: _isAdult,
                    title: Text('(필수) 14세 이상입니다.',
                        style: TextStyle(fontSize: Adaptive.dp(12))),
                    onChanged: (value) => setState(() => _isAdult = value!)),
                CheckboxListTile(
                    value: _agreeUsage,
                    title: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: false,
                              isDismissible: true,
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) => WebView(
                                  gestureRecognizers: Set()
                                    ..add(Factory<
                                            VerticalDragGestureRecognizer>(
                                        () => VerticalDragGestureRecognizer())),
                                  initialUrl: 'https://arounduspp2.oopy.io/',
                                  javascriptMode: JavascriptMode.unrestricted,
                                  onPageFinished: (finish) {
                                    setState(() {});
                                  }));
                        },
                        child: Text('(필수) 서비스 이용약관',
                            style: TextStyle(
                                fontSize: Adaptive.dp(12),
                                decoration: TextDecoration.underline))),
                    onChanged: (value) => setState(() => _agreeUsage = value!)),
                CheckboxListTile(
                    value: _personalInfo,
                    title: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: false,
                              isDismissible: true,
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) => WebView(
                                  gestureRecognizers: Set()
                                    ..add(Factory<
                                            VerticalDragGestureRecognizer>(
                                        () => VerticalDragGestureRecognizer())),
                                  initialUrl:
                                      'ttps://aroundusprivacypolicy.oopy.io/',
                                  javascriptMode: JavascriptMode.unrestricted,
                                  onPageFinished: (finish) {
                                    setState(() {});
                                  }));
                        },
                        child: Text('(필수) 개인정보 수집 및 이용동의',
                            style: TextStyle(
                                fontSize: Adaptive.dp(12),
                                decoration: TextDecoration.underline))),
                    onChanged: (value) =>
                        setState(() => _personalInfo = value!))
              ]))
        ]));
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
