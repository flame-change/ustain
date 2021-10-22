import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_scrapped_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/magazine_home_page.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/magazine_scrapped_page.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/base_component/bottom_navbar.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class MagazineHomeScreen extends StatefulWidget {
  static String routeName = 'magazine_home_screen';

  @override
  State<StatefulWidget> createState() => _MagazineHomeScreen();
}

class _MagazineHomeScreen extends State<MagazineHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              title: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: TabBar(
                    isScrollable: true,
                    tabs: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("매거진")),
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("스크랩"))
                    ],
                    indicator: UnderlineTabIndicator(
                        borderSide:
                            BorderSide(width: 4, color: theme.accentColor),
                        insets: EdgeInsets.only(bottom: -6)),
                    labelStyle: theme.textTheme.button!
                        .copyWith(fontSize: Adaptive.dp(20)),
                    labelColor: Colors.black,
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.only(right: 20),
                  ),
                ),
              ),
              actions: [
                Icon(Icons.notifications, size: Adaptive.sp(20)),
              ],
            ),
            body: TabBarView(
              children: [
                BlocProvider(
                    create: (_) => MagazineCubit(
                        RepositoryProvider.of<MagazineRepository>(context)),
                    child: LeftPageWire(child: MagazineHomePage())),
                BlocProvider(
                    create: (_) => MagazineScrappedCubit(
                        RepositoryProvider.of<MagazineRepository>(context)),
                    child: PageWire(child: MagazineScrappedPage())),
              ],
            ),
            bottomNavigationBar:
                BottomNavBar(selectedMenu: MenuState.magazine)));
  }
}
