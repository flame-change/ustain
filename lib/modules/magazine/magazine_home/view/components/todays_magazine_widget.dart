import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/view/components/magazine_card_todays_widget.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: RichText(
            text: TextSpan(
                style: theme.textTheme.headline3!
                    .copyWith(height: 1.5),
                children: [
                  TextSpan(text: "TRENDING "),
                  TextSpan(
                    text: "NOW\n",
                    style: TextStyle(color: theme.accentColor),
                  ),
                  TextSpan(
                    text: "좋아하실 만한 읽을거리를 가져왔어요.",
                    style: theme.textTheme.subtitle1
                  )
                ]),
          ),
        ),
        Container(
            height: Adaptive.h(40),
            margin: EdgeInsets.only(bottom: Adaptive.h(3)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 30,
                  children: List.generate(
                      _todaysMaagazines.length,
                      (index) => Container(
                          width: sizeWith(60),
                          child: todaysMagazineCard(
                              context, _todaysMaagazines[index])))),
            )),
        Divider()
      ],
    );
  }
}
