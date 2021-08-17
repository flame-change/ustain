import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/support/base_component/page_wire.dart';
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

  @override
  void initState() {
    super.initState();
    _magazineCubit = BlocProvider.of<MagazineCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return PageWire(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TodaysMagazine()
            // BlocProvider.value(value: _magazineCubit, child: TodaysMagazine()),
          ],
        ),
      ),
    );
  }
}
