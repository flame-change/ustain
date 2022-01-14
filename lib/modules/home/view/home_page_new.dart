import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/modules/home/catalog/view/catalog_screen.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/home/components/catalog_list.dart';
import 'package:aroundus_app/support/base_component/company_info.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomePageNew extends StatefulWidget {
  static String routeName = '/home_page';

  @override
  _HomePageNewState createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  late MagazineCubit _magazineCubit;

  @override
  void initState() {
    super.initState();
    _magazineCubit = BlocProvider.of<MagazineCubit>(context);
    _magazineCubit.getCatalogMagazine();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:
          BlocBuilder<MagazineCubit, MagazineState>(builder: (context, state) {
        return CustomScrollView(shrinkWrap: true, slivers: <Widget>[
          // 카탈로그 시작 전
          SliverToBoxAdapter(
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Container(
                      color: Colors.black,
                      padding: EdgeInsets.only(
                          left: sizeWidth(5),
                          top: AppBar().preferredSize.height,
                          bottom: sizeWidth(5)),
                      child: Container(
                          color: Colors.black,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: Adaptive.dp(10)),
                                      height: 5,
                                      color: Colors.white,
                                      width: double.maxFinite),
                                  Container(
                                      color: Colors.black,
                                      child: Text("MD's PICK ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white)))
                                ]),
                                SizedBox(height: Adaptive.h(0.3)),
                                Container(
                                    color: Colors.black,
                                    child: Text('어스테인 MD의 추천 상품을 모아봤어요.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.white)))
                              ]))))),
          // 카탈로그 카드 들어갈 곳
          state.catalogMagazines != null
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CatalogScreen(
                                      id: state.catalogMagazines![index].id!))),
                          child: CatalogCard(
                              state.catalogMagazines![index], index + 1)),
                      childCount: state.catalogMagazines!.length))
              : SliverToBoxAdapter(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                          top: Adaptive.h(10), bottom: Adaptive.h(25)),
                      child: Center(
                          child: Image.asset('assets/images/indicator.gif')))),
          SliverToBoxAdapter(
              child: MediaQuery.removePadding(
                  context: context, removeTop: true, child: CompanyInfo()))
        ]);
      }),
    );
  }
}
