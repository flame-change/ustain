import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class TodaysMagazine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodaysMagazineState();
}

class _TodaysMagazineState extends State<TodaysMagazine> {
  final _scrollController = ScrollController();

  late MagazineCubit _magazineCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _magazineCubit = BlocProvider.of<MagazineCubit>(context);
    _magazineCubit.getMainMagazines();
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
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        Text(
          "좋아하실 만한 읽을거리를 가져왔어요",
          style: TextStyle(fontSize: 15.sp, color: Color(0xFF979797)),
        ),
        Container(
          height: 30.h,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _magazineCubit.state.todaysMaagazines!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 10),
                width: 60.w,
                color: Colors.black38,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Container(
                        height: 20.h,
                        width: 100.w,
                        child: Image.network(
                          _magazineCubit
                              .state.todaysMaagazines![index].bannerImage!,
                          fit: BoxFit.cover,
                        )),
                    Container(
                        width: 100.w,
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _magazineCubit
                                  .state.todaysMaagazines![index].title!,
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            Text(
                                "${_magazineCubit.state.todaysMaagazines![index].title!} 설명",
                                style: TextStyle(fontSize: 12.sp)),
                          ],
                        ))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
