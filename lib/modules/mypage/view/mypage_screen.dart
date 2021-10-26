import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/mypage/settings/view/settings_screen.dart';
import 'package:aroundus_app/support/base_component/bottom_navbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'mypage_page.dart';

class MyPageScreen extends StatefulWidget {
  static String routeName = 'my_page_screen';

  MyPageScreen({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MyPageScreen());
  }

  @override
  State<MyPageScreen> createState() => _MyPageScreen();
}

class _MyPageScreen extends State<MyPageScreen>
    with AutomaticKeepAliveClientMixin<MyPageScreen> {
  @override
  bool get wantKeepAlive => true;

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
              create: (context) => BlocProvider.of<AuthenticationBloc>(context))
        ],
        child: Scaffold(
            appBar: AppBar(
                brightness: Brightness.dark,
                backgroundColor: Colors.black,
                centerTitle: false,
                title: Text('프로필',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
                actions: [
                  GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, SettingsScreen.routeName),
                      child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.settings,
                              color: Colors.white, size: 25)))
                ]),
            body: SingleChildScrollView(child: MyPage())));
  }
}
