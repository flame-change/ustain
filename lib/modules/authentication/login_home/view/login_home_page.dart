import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:aroundus_app/modules/authentication/signin/view/signin_page.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/modules/authentication/signup/view/phone_verify_page.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginHomePage extends StatefulWidget {
  static String routeName = 'login_home_page';

  @override
  _LoginHomePagePageState createState() => _LoginHomePagePageState();
}

class _LoginHomePagePageState extends State<LoginHomePage> {
  late AuthenticationStatus _authenticationStatus;
  late AuthenticationState _authenticationState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWire(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlainButton(text: "카카오 로그인", onPressed: () {}),
        PlainButton(text: "애플 로그인", onPressed: () {}),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                          create: (context) => SignupCubit(
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                          child: PhoneVerifyPage()),
                    ));
              },
              child: Text("일반 회원가입"),
            ),
            Text(" | "),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (_) => SignInCubit(RepositoryProvider.of<
                                  AuthenticationRepository>(context)),
                              child: SignInPage(),
                            )));
              },
              child: Text("일반 로그인"),
            ),
          ],
        )
      ],
    ));
  }
}
