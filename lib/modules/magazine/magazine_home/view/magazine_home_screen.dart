import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_scrapped_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/magazine_home_page.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/magazine_scrapped_page.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/components/main_screen_wire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MagazineHomeScreen extends StatefulWidget {
  static String routeName = '/magazine_home_screen';

  @override
  State<StatefulWidget> createState() => _MagazineHomeScreen();
}

class _MagazineHomeScreen extends State<MagazineHomeScreen>
    with AutomaticKeepAliveClientMixin<MagazineHomeScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return MainScreenWire(
        page1Title: Text('매거진'),
        page2Ttile: Text('스크랩'),
        action: Container(),
        indicatorWidth: 4.0,
        firstPage: BlocProvider(
            create: (_) => MagazineCubit(
                RepositoryProvider.of<MagazineRepository>(context)),
            child: LeftPageWire(child: MagazineHomePage())),
        secondPage: BlocProvider(
            create: (_) => MagazineScrappedCubit(
                RepositoryProvider.of<MagazineRepository>(context)),
            child: PageWire(child: MagazineScrappedPage())));
  }
}
