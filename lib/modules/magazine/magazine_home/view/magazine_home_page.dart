import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/base_component/company_info.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'components/todays_magazine_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/magazine_card_widget.dart';
import 'package:flutter/material.dart';

class MagazineHomePage extends StatefulWidget {
  static String routeName = '/magazine_home_page';

  @override
  _MagazineHomePageState createState() => _MagazineHomePageState();
}

class _MagazineHomePageState extends State<MagazineHomePage> {
  late MagazineCubit _magazineCubit;
  final _scrollController = ScrollController();
  late User user;

  @override
  void initState() {
    super.initState();
    _magazineCubit = BlocProvider.of<MagazineCubit>(context);
    _scrollController.addListener(_onScroll);
    user = context.read<AuthenticationBloc>().state.user;
    getMagazineMethods(context);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0) {
      _magazineCubit.getMagazinesByCategory(
          magazineCategory: _magazineCubit.state.magazineCategory);
    }
  }

  void getMagazineMethods(BuildContext context) {
    _magazineCubit.getMagazinesByCategory(
        magazineCategory: MagazineCategory.empty);
    _magazineCubit.getMainMagazines();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async => getMagazineMethods(context),
        child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            child: BlocBuilder<MagazineCubit, MagazineState>(
                builder: (context, state) {
              if (state.todaysMagazines != null && state.magazines != null) {
                return Column(children: [
                  LeftPageWire(
                      child: Wrap(runSpacing: 15, children: [
                    // 오늘의 매거진
                    TodaysMagazine(todaysMagazines: state.todaysMagazines!),
                    // 모아보기
                    TitleWithUnderline(
                        title: "WHAT'S NEW?", subtitle: "어스테인의 정기 간행물 입니다."),
                    // TODO 카테고리들 스크롤링 뷰
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        height: 40,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: categoryTitle())),
                    Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                            state.magazines!.length,
                            (index) => Padding(
                                padding: EdgeInsets.only(right: sizeWidth(5)),
                                child: magazineCard(
                                    context, state.magazines![index]))))
                  ])),
                  SizedBox(height: Adaptive.h(5)),
                  CompanyInfo()
                ]);
              } else {
                return Container(
                    height: Adaptive.h(100),
                    child: Center(child: CircularProgressIndicator()));
              }
            })));
  }

  List<Widget> categoryTitle() {
    print("magazine ${_magazineCubit.state.magazineCategory}");

    return <Widget>[
          GestureDetector(
              onTap: () {
                print("전체보기");
                _magazineCubit.getMagazinesByCategory(
                    magazineCategory: MagazineCategory.empty);
              },
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: _magazineCubit.state.magazineCategory ==
                              MagazineCategory.empty
                          ? Colors.black
                          : Colors.white,
                      border: Border.all(
                          color: _magazineCubit.state.magazineCategory ==
                                  MagazineCategory.empty
                              ? Colors.black
                              : Colors.grey)),
                  child: Text("전체보기",
                      style: TextStyle(
                        color: _magazineCubit.state.magazineCategory ==
                                MagazineCategory.empty
                            ? Colors.white
                            : Colors.black,
                      ))))
        ] +
        List<Widget>.generate(
            user.categories!.length,
            (index) => GestureDetector(
                onTap: () {
                  print(user.categories![index].title);
                  _magazineCubit.getMagazinesByCategory(
                      magazineCategory: user.categories![index]);
                },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: _magazineCubit.state.magazineCategory ==
                                user.categories![index]
                            ? Colors.black
                            : Colors.white,
                        border: Border.all(
                            color: _magazineCubit.state.magazineCategory ==
                                    user.categories![index]
                                ? Colors.black
                                : Colors.grey)),
                    child: Text(user.categories![index].mid!,
                        style: TextStyle(
                            color: _magazineCubit.state.magazineCategory ==
                                    user.categories![index]
                                ? Colors.white
                                : Colors.black)))));
  }
}
