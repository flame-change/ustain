import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:aroundus_app/modules/authentication/signin/view/signin_page.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/modules/authentication/signup/view/phone_verify_page.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: sizeWith(100),
          height: Adaptive.h(75),
          child: Padding(
            padding: basePadding(vertical: Adaptive.h(3)),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Adaptive.h(15)),
                  child: Image.asset(
                    'assets/images/logo_group.png',
                    width: sizeWith(30),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WE\nARE\nSELFISH",
                        style: theme.textTheme.headline1!
                            .copyWith(color: Colors.white, height: 1.2),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: Adaptive.h(25),
          color: Colors.white,
          padding: basePadding(vertical: 2),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PlainButton(
                    text: "로그인",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                    create: (_) => SignInCubit(
                                        RepositoryProvider.of<
                                            AuthenticationRepository>(context)),
                                    child: SignInPage(),
                                  )));
                    },
                  height: 7,
                ),
                PlainButton(
                    text: "회원가입",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                                create: (context) => SignupCubit(
                                    RepositoryProvider.of<
                                        AuthenticationRepository>(context)),
                                child: PhoneVerifyPage()),
                          ));
                    },
                  height: 7,
                  color: Colors.white,
                  borderColor: theme.accentColor,
                ),
                InkWell(
                  onTap: () {
                    // TODO 명세 확인 필요
                  },
                  child: Text(
                    "둘러보기",
                    style: theme.textTheme.subtitle1!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
