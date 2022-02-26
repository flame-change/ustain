import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'mypage_page.dart';

class MyPageScreen extends StatefulWidget {
  static String routeName = '/my_page_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MyPageScreen());
  }

  @override
  State<MyPageScreen> createState() => _MyPageScreen();
}

class _MyPageScreen extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));

    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(child: SingleChildScrollView(child: MyPage()))));
  }
}
