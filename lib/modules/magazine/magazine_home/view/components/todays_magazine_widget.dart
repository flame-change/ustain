import 'package:aroundus_app/modules/magazine/magazine_detail/view/components/magazine_card_todays_widget.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TitleWithUnderline(
              title: "TRENDING NOW", subtitle: "좋아하실 만한 읽을거리를 가져왔어요.")),
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
                              context, _todaysMaagazines[index])))))),
      Divider(height: 0)
    ]);
  }
}
