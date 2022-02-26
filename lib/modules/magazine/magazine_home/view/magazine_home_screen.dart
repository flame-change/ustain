import 'package:aroundus_app/modules/magazine/magazine_home/view/magazine_scrapped_page.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/magazine_home_page.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_scrapped_cubit.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

    return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
            child: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                            centerTitle: false,
                            pinned: false,
                            floating: true,
                            snap: false,
                            elevation: 0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            flexibleSpace: FlexibleSpaceBar(
                                background: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: Adaptive.w(5)),
                                        child: Text('Magazines',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500)))))),
                        SliverOverlapAbsorber(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                            sliver: SliverPersistentHeader(
                                pinned: true, delegate: TabBarDelegate()))
                      ];
                    },
                    body: Column(children: [
                      SizedBox(height: 48),
                      Expanded(
                          child: TabBarView(children: [
                        BlocProvider(
                            create: (_) => MagazineCubit(
                                RepositoryProvider.of<MagazineRepository>(
                                    context)),
                            child: MagazineHomePage()),
                        BlocProvider(
                            create: (_) => MagazineScrappedCubit(
                                RepositoryProvider.of<MagazineRepository>(
                                    context)),
                            child: MagazineScrappedPage())
                      ]))
                    ])))));
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: EdgeInsets.only(left: sizeWidth(5)),
                child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: Theme.of(context).textTheme.headline5,
                    isScrollable: true,
                    tabs: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('매거진')),
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('스크랩'))
                    ],
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: Colors.black),
                        insets: EdgeInsets.only(bottom: -6)),
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.only(right: 20)))));
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
