import 'package:aroundus_app/repositories/mypage_repository/src/mypage_repository.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/mypage/user_info/view/user_info_page.dart';
import 'package:aroundus_app/modules/mypage/cubit/mypage_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  static String routeName = '/user_info_screen';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  BlocProvider.of<AuthenticationBloc>(context)),
          BlocProvider(
              create: (_) =>
                  MypageCubit(RepositoryProvider.of<MypageRepository>(context)))
        ],
        child: Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
                automaticallyImplyLeading: true,
                elevation: 0,
                backgroundColor: Colors.black,
                centerTitle: false),
            body: SingleChildScrollView(child: UserInfoPage())));
  }
}
