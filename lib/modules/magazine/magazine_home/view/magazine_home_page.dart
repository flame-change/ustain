import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_detail_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'components/magazine_card_widget.dart';
import 'components/todays_magazine_widget.dart';

class MagazineHomePage extends StatefulWidget {
  static String routeName = 'magazine_home_page';

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
    _magazineCubit.getMagazinesByCategory(
        magazineCategory: MagazineCategory.empty);
    _magazineCubit.getMainMagazines();
    _scrollController.addListener(_onScroll);
    user = context.read<AuthenticationBloc>().state.user;
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0) {
      _magazineCubit.getMagazinesByCategory(
          magazineCategory: _magazineCubit.state.magazineCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: _scrollController,
        child: BlocBuilder<MagazineCubit, MagazineState>(
          builder: (context, state) {
            if (state.todaysMaagazines != null && state.magazines != null) {
              return Wrap(runSpacing: 15, children: [
                // 오늘의 매거진
                TodaysMagazine(state.todaysMaagazines!),

                // 모아보기
                RichText(
                  text: TextSpan(
                      style: theme.textTheme.headline3!.copyWith(height: 1.5),
                      children: [
                        TextSpan(
                          text: "WHAT’S NEW?\n",
                          style: TextStyle(color: theme.accentColor),
                        ),
                        TextSpan(
                            text: "존나 새로운 시각의 브랜드 스토리",
                            style: theme.textTheme.subtitle1)
                      ]),
                ),
                // TODO 카테고리들 스크롤링 뷰
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categoryTitle(),
                  ),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                      state.magazines!.length,
                      (index) =>
                          magazineCard(context, state.magazines![index])),
                ),
              ]);
            } else {
              return Container(
                  height: Adaptive.h(100),
                  child: Center(child: CircularProgressIndicator()));
            }
          },
        ));
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
              child: Text(
                "전체보기",
                style: TextStyle(
                  color: _magazineCubit.state.magazineCategory ==
                          MagazineCategory.empty
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          )
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
                    child: Text(
                      user.categories![index].title!,
                      style: TextStyle(
                        color: _magazineCubit.state.magazineCategory ==
                                user.categories![index]
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ));
  }
}
