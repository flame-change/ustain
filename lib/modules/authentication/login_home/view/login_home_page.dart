import 'package:aroundus_app/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:aroundus_app/modules/authentication/signin/view/signin_page.dart';
import 'package:aroundus_app/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/modules/authentication/signup/view/phone_verify_page.dart';
import 'package:aroundus_app/modules/main/main_screen.dart';
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
  late AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          width: sizeWith(100),
          height: Adaptive.h(70),
          child: Padding(
              padding: basePadding(vertical: Adaptive.h(3)),
              child:
                  Stack(alignment: AlignmentDirectional.topCenter, children: [
                Image.asset('assets/images/splash_screen.png',
                    width: sizeWith(50)),
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
                          )
                        ]))
              ]))),
      Container(
          height: Adaptive.h(30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25))),
          padding: EdgeInsets.all(Adaptive.w(5)),
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
                                                    AuthenticationRepository>(
                                                context)),
                                        child: SignInPage(),
                                      )));
                        },
                        height: 7),
                    PlainButton(
                        text: "회원가입",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                      create: (context) => SignupCubit(
                                          RepositoryProvider.of<
                                                  AuthenticationRepository>(
                                              context)),
                                      child: PhoneVerifyPage())));
                        },
                        height: 7,
                        color: Colors.white,
                        borderColor: theme.accentColor),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, MainScreen.routeName);
                          _authenticationRepository.travel();
                        },
                        child: Text("둘러보기",
                            style: theme.textTheme.subtitle1!.copyWith(
                                decoration: TextDecoration.underline)))
                  ])))
    ]);
  }
}
