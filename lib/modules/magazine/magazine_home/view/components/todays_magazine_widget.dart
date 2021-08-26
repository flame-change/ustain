import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:flutter/material.dart';
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
              itemCount: _todaysMaagazines.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 65.w,
                  color: Colors.black38,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Image.network(
                          _todaysMaagazines[index].bannerImage!,
                          width: 65.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                          width: 100.w,
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _todaysMaagazines[index].title!,
                                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "${_todaysMaagazines[index].title!} 설명",
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
