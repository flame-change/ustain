import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'magazine_card_widget.dart';

class TodaysMagazine extends StatefulWidget {
  final List<Magazine> todaysMaagazines;

  TodaysMagazine(this.todaysMaagazines);

  @override
  State<StatefulWidget> createState() => _TodaysMagazineState();
}

class _TodaysMagazineState extends State<TodaysMagazine>
    with SingleTickerProviderStateMixin {
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
          style:
              TextStyle(fontSize: Adaptive.sp(20), fontWeight: FontWeight.bold),
        ),
        Text(
          "좋아하실 만한 읽을거리를 가져왔어요",
          style: TextStyle(fontSize: Adaptive.sp(15), color: Color(0xFF979797)),
        ),
        Container(
            height: Adaptive.h(30),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 15,
                  children: List.generate(
                      _todaysMaagazines.length,
                      (index) => Container(
                          width: Adaptive.w(100) > 475
                              ? 475 / 100 * 65
                              : Adaptive.w(65),
                          child: magazineCard(
                              context, _todaysMaagazines[index])))),
            ))
      ],
    );
  }
}
