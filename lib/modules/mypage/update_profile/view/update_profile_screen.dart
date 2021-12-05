import 'package:aroundus_app/repositories/mypage_repository/src/mypage_repository.dart';
import 'package:aroundus_app/modules/mypage/settings/view/settings_screen.dart';
import 'package:aroundus_app/modules/mypage/cubit/mypage_cubit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'update_profile_page.dart';

class UpdateProfileScreen extends StatefulWidget {
  static String routeName = '/update_profile';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UpdateProfileScreen());
  }

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreen();
}

class _UpdateProfileScreen extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  MypageCubit(RepositoryProvider.of<MypageRepository>(context)))
        ],
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
              automaticallyImplyLeading: true,
              elevation: 0,
              brightness: Brightness.dark,
              backgroundColor: Colors.grey.shade100,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, SettingsScreen.routeName),
                    child: Padding(
                        padding: EdgeInsets.only(right: sizeWidth(5)),
                        child: Icon(Icons.settings, color: Colors.white)))
              ]),
          body: SingleChildScrollView(child: UpdateProfilePage()),
          bottomNavigationBar: Container(
              height: Adaptive.h(10),
              width: sizeWidth(100),
              decoration: BoxDecoration(
                  color: Colors.black, border: Border.all(color: Colors.black)),
              child: Center(
                  child: GestureDetector(
                      onTap: () {},
                      child: Text('수정 완료',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white))))),
        ));
  }
}
