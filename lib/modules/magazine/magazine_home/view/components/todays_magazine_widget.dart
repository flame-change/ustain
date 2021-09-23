import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:sizer/sizer.dart';

class TodaysMagazine extends StatefulWidget {
  final List<Magazine> todaysMaagazines;

  TodaysMagazine(this.todaysMaagazines);

  @override
  State<StatefulWidget> createState() => _TodaysMagazineState();
}

class _TodaysMagazineState extends State<TodaysMagazine> with SingleTickerProviderStateMixin{

  List<Magazine> get _todaysMaagazines => this.widget.todaysMaagazines;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0) {
      // _broadcastCubit.getLiveBroadcastListInit();
    }
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "오늘의 매거진📚",
            style: TextStyle(fontSize: Adaptive.sp(20), fontWeight: FontWeight.bold),
          ),
          Text(
            "좋아하실 만한 읽을거리를 가져왔어요",
            style: TextStyle(fontSize: Adaptive.sp(15), color: Color(0xFF979797)),
          ),
          Container(
            height: Adaptive.h(30),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _todaysMaagazines.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(_todaysMaagazines[index]);
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
                                  _todaysMaagazines[index].id!)),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: Adaptive.w(65),
                    color: Colors.black38,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Image.network(
                            _todaysMaagazines[index].bannerImage!,
                            width: Adaptive.w(65),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                            width: Adaptive.w(100),
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _todaysMaagazines[index].title!,
                                  style: TextStyle(fontSize: Adaptive.sp(15), fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${_todaysMaagazines[index].title!} 설명",
                                    style: TextStyle(fontSize: Adaptive.sp(12))),
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
  }
}
