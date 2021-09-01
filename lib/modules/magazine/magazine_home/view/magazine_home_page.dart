import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_detail_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'components/todays_magazine_widget.dart';

class MagazineHomePage extends StatefulWidget {
  static String routeName = 'magazine_home_page';

  @override
  _MagazineHomePageState createState() => _MagazineHomePageState();
}

class _MagazineHomePageState extends State<MagazineHomePage> {
  late MagazineCubit _magazineCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _magazineCubit = BlocProvider.of<MagazineCubit>(context);
    _magazineCubit.getMagazinesByCategory();
    _magazineCubit.getMainMagazines();
    _scrollController.addListener(_onScroll);
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "모아보기📚",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "어쩌구 저쩌구!",
                      style:
                          TextStyle(fontSize: 15.sp, color: Color(0xFF979797)),
                    ),
                    // TODO 카테고리들 스크롤링 뷰
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      height: 5.h,
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
                          (index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider<MagazineDetailCubit>(
                                                create: (context) =>
                                                    MagazineDetailCubit(
                                                        RepositoryProvider.of<
                                                                MagazineRepository>(
                                                            context)),
                                              )
                                            ],
                                            child: MagazineDetailPage(
                                                state.magazines![index].id!)),
                                      ));
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 30.h,
                                  color: Colors.black38,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        state.magazines![index].bannerImage!,
                                        height: 20.h,
                                        width: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        state.magazines![index].title!,
                                        style: TextStyle(fontSize: 20.sp),
                                      ),
                                      Text(
                                        "매거진 내용 최대 두 줄",
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                    )
                  ],
                ),
              ]);
            } else {
              return Container(
                  height: 100.h,
                  child: Center(child: CircularProgressIndicator()));
            }
          },
        ));
  }

  List<Widget> categoryTitle() {
    return List<Widget>.generate(
        MagazineCategory.values.length,
        (index) => GestureDetector(
              onTap: () {
                print(MagazineCategory.values[index].name);
                _magazineCubit.getMagazinesByCategory(
                    magazineCategory: MagazineCategory.values[index]);
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: _magazineCubit.state.magazineCategory ==
                            MagazineCategory.values[index]
                        ? Colors.lightBlue
                        : Colors.black12,
                    borderRadius: BorderRadius.circular(25)),
                child: Text(MagazineCategory.values[index].name),
              ),
            ));
  }
}
