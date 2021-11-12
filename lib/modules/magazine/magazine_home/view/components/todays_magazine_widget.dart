import 'package:aroundus_app/modules/magazine/magazine_detail/view/components/magazine_card_todays_widget.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class TodaysMagazine extends StatefulWidget {
  final List<Magazine> todaysMagazines;

  TodaysMagazine(this.todaysMagazines);

  @override
  State<StatefulWidget> createState() => _TodaysMagazineState();
}

class _TodaysMagazineState extends State<TodaysMagazine>
    with SingleTickerProviderStateMixin {
  List<Magazine> get _todaysMagazines => this.widget.todaysMagazines;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: webPadding()),
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
                          _todaysMagazines.length,
                          (index) => Container(
                              width: sizeWith(60),
                              child: todaysMagazineCard(
                                  context, _todaysMagazines[index]))) +
                      [Container()]))),
      Divider(height: 0)
    ]);
  }
}
