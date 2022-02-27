import 'package:aroundus_app/modules/magazine/magazine_detail/view/components/magazine_card_todays_widget.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class TodaysMagazine extends StatefulWidget {
  final List<Magazine>? todaysMagazines;
  final bool isMain;

  TodaysMagazine({@required this.todaysMagazines, this.isMain = true});

  @override
  State<StatefulWidget> createState() => _TodaysMagazineState();
}

class _TodaysMagazineState extends State<TodaysMagazine>
    with SingleTickerProviderStateMixin {
  List<Magazine>? get _todaysMagazines => this.widget.todaysMagazines;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.isMain == true)
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 15),
          TitleWithUnderline(
              title: "TODAY's MAGs", subtitle: '좋아하실만한 읽을거리를 준비했어요.'),
          SizedBox(height: 20)
        ]),
      Container(
          height: Adaptive.w(90),
          margin: EdgeInsets.only(bottom: Adaptive.h(3)),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 30,
                  children: List.generate(
                          _todaysMagazines!.length,
                          (index) => Container(
                              width: sizeWidth(60),
                              child: todaysMagazineCard(
                                  context, _todaysMagazines![index]))) +
                      [Container()])))
    ]);
  }
}
