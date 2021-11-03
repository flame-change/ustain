import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/modules/authentication/account/view/finding_password_page.dart';
import 'package:aroundus_app/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SignInPage extends StatefulWidget {
  static String routeName = 'signIn_page';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late SignInCubit _signInCubit;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signInCubit = BlocProvider.of<SignInCubit>(context);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.black, title: mainLogo()),
        body: BlocListener<SignInCubit, SignInState>(
            listener: (context, state) async {
              if (state.errorMessage != null &&
                  state.errorMessage!.length > 0) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('${state.errorMessage}')),
                  );
                _signInCubit.errorMsg();
              }
            },
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    color: Colors.black,
                    alignment: Alignment.centerLeft,
                    padding: basePadding(vertical: Adaptive.h(10)),
                    child: RichText(
                        text: TextSpan(
                            style: theme.textTheme.headline3!
                                .copyWith(color: Colors.white, height: 1.5),
                            children: [
                          TextSpan(text: "다시 만나서\n"),
                          TextSpan(text: "반가워요!"),
                          TextSpan(
                              text: ":)",
                              style: theme.textTheme.headline2!
                                  .copyWith(color: theme.accentColor))
                        ]))),
                Container(
                  color: Colors.black,
                  child: Container(
                      padding: basePadding(vertical: Adaptive.w(5)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25))),
                      child: Wrap(runSpacing: 15, children: [
                        Text("LOGIN",
                            style: theme.textTheme.headline2!
                                .copyWith(fontSize: Adaptive.dp(20))),
                        _phoneNumberInput(),
                        _passwordInput(),
                        PlainButton(
                          onPressed: () {
                            _signInCubit.signIn(
                                phoneNumber: _phoneNumberController.text
                                    .trim()
                                    .replaceAll("-", ""),
                                password: _passwordController.text.trim());
                          },
                          text: "로그인",
                          height: 7,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        BlocProvider<FindingAccountCubit>(
                                      create: (context) => FindingAccountCubit(
                                        RepositoryProvider.of<
                                            AuthenticationRepository>(context),
                                      ),
                                      child: FindingPasswordPage(),
                                    ),
                                  ));
                            },
                            child: Center(
                                child: Text("비밀번호 찾기",
                                    style: theme.textTheme.bodyText2!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFFB7B7B7)))))
                      ])),
                )
              ]),
            )));
  }

  Widget _phoneNumberInput() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        controller: _phoneNumberController,
        inputFormatters: [
          MaskedInputFormatter('000-0000-0000',
              allowedCharMatcher: RegExp('[0-9]'))
        ],
        cursorColor: Colors.black,
        style: TextStyle(decorationColor: Color(0XFFFFCC00)),
        decoration: InputDecoration(
            counterText: "",
            labelText: "휴대폰 번호",
            filled: true,
            fillColor: Colors.white.withOpacity(0.4)));
  }

  Widget _passwordInput() {
    return TextFormField(
        maxLength: 60,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        cursorColor: Colors.black,
        controller: _passwordController,
        decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: Colors.white.withOpacity(0.4),
            labelText: "비밀번호"));
  }
}
