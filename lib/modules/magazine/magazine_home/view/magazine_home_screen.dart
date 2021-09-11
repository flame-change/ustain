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
import 'package:sizer/sizer.dart';

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
                  width: 50.w,
                  child: TabBar(
                    tabs: <Widget>[
                      Text("매거진",
                          style:TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      Text("스크랩",
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              actions: [
                Icon(Icons.notifications, size: 20.sp),
              ],
            ),
            body: TabBarView(
              children: [
                BlocProvider(
                    create: (_) => MagazineCubit(
                        RepositoryProvider.of<MagazineRepository>(context)),
                    child: PageWire(child: MagazineHomePage())),
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
