import 'package:aroundus_app/modules/home/catalog/view/catalog_screen.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/components/todays_magazine_widget.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/modules/home/components/main_carousel.dart';
import 'package:aroundus_app/modules/home/components/catalog_list.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MagazineCubit _magazineCubit;

  @override
  void initState() {
    super.initState();
    _magazineCubit = BlocProvider.of<MagazineCubit>(context);
    _magazineCubit.getMainMagazines();
    _magazineCubit.getBannerMagazines();
    _magazineCubit.getCatalogMagazine();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MagazineCubit, MagazineState>(builder: (context, state) {
      return CustomScrollView(slivers: <Widget>[
        // 메인 캐러셀 부분입니다.
        SliverAppBar(
            leading: Container(),
            backgroundColor: Colors.white,
            brightness: Brightness.dark,
            expandedHeight: Adaptive.h(50),
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                    alignment: Alignment.bottomLeft,
                    fit: StackFit.expand,
                    children: [
                  state.bannerMagazines != null
                      ? BannerMagazines(state.bannerMagazines!)
                      : Container(color: Colors.grey)
                ]))),

        // 메인 매거진 부분입니다.
        SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.only(
                    top: Adaptive.w(5),
                    bottom: Adaptive.w(5),
                    left: Adaptive.w(5)),
                child: state.todaysMagazines != null
                    ? TodaysMagazine(state.todaysMagazines!)
                    : Container(
                        height: Adaptive.h(40),
                        child: Center(child: CircularProgressIndicator())))),
        // 카탈로그 시작 전
        SliverToBoxAdapter(
            child: Padding(
                padding:
                    EdgeInsets.only(left: Adaptive.w(5), bottom: Adaptive.w(5)),
                child: TitleWithUnderline(
                    title: "MD's PICK", subtitle: '어스테인 MD의 추천 상품을 모아봤어요.'))),
        // 카탈로그 카드 들어갈 곳
        state.catalogMagazines != null
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CatalogScreen(
                                      id: state.catalogMagazines![index].id!)),
                            ),
                        child: CatalogCard(
                            state.catalogMagazines![index], index + 1)),
                    childCount: state.catalogMagazines!.length))
            : SliverToBoxAdapter(child: Container())
      ]);
    });
  }
}
