import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/support/base_component/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mypage_page.dart';

class MyPageScreen extends StatefulWidget {
  static String routeName = 'home_screen';

  MyPageScreen({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MyPageScreen());
  }

  @override
  State<MyPageScreen> createState() => _MyPageScreen();
}

class _MyPageScreen extends State<MyPageScreen> {
  late AuthenticationBloc _authenticationBloc;

  @override
  void initSate() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BlocProvider.of<AuthenticationBloc>(context),
          ),
        ],
        child: Scaffold(
          body: MyPage(),
          bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.my_page),
        ));
  }
}
