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
    return BlocBuilder<MagazineCubit, MagazineState>(builder: (context, state) {
      return CustomScrollView(shrinkWrap: true, slivers: <Widget>[
        // 카탈로그 시작 전
        SliverToBoxAdapter(
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        left: sizeWidth(5),
                        top: AppBar().preferredSize.height,
                        bottom: sizeWidth(5)),
                    child: TitleWithUnderline(
                        title: "MD's PICK",
                        subtitle: '어스테인 MD의 추천 상품을 모아봤어요.')))),
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
                    padding: EdgeInsets.only(top: Adaptive.h(30)),
                    child: Center(child: CircularProgressIndicator()))),
        SliverToBoxAdapter(
            child: MediaQuery.removePadding(
                context: context, removeTop: true, child: CompanyInfo()))
      ]);
    });
  }
}
