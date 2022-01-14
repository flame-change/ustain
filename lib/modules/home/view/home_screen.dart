import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/home/view/home_page_new.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../home.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black, statusBarBrightness: Brightness.dark));

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => MagazineCubit(
                  RepositoryProvider.of<MagazineRepository>(context)))
        ],
        child: Stack(alignment: Alignment.topCenter, children: <Widget>[
          TabBarView(controller: _tabController, children: [
            HomePage(),
            Container(
                color: Colors.black, child: SafeArea(child: HomePageNew()))
          ]),
          Container(
              padding: EdgeInsets.only(top: 13, left: 16),
              width: double.maxFinite,
              child: SafeArea(
                  child: Container(
                width: double.maxFinite,
                color: Colors.transparent,
                child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child:
                              Text('홈', style: TextStyle(color: Colors.white))),
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('카탈로그',
                              style: TextStyle(color: Colors.white)))
                    ],
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: Colors.white),
                        insets: EdgeInsets.only(bottom: -6)),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(fontSize: Adaptive.dp(20)),
                    labelColor: Colors.white,
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.only(right: 20)),
              )))
        ]));
  }
}
