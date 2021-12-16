import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/support/style/size_util.dart';
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
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => BlocProvider.of<AuthenticationBloc>(context))
        ],
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                brightness: Brightness.dark,
                backgroundColor: Colors.black,
                centerTitle: false,
                title: Text('프로필',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white))),
            body: SingleChildScrollView(child: MyPage())));
  }
}
