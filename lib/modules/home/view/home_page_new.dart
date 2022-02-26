import 'package:aroundus_app/modules/magazine/magazine_home/view/components/todays_magazine_widget.dart';
import 'package:aroundus_app/modules/home/catalog/view/catalog_screen.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/home/components/catalog_list.dart';
import 'package:aroundus_app/support/base_component/page_wire.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomePageNew extends StatefulWidget {
  static String routeName = '/home_page';

  @override
  _HomePageNewState createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  late MagazineCubit _magazineCubit;

  @override
  void initState() {
    super.initState();
    _magazineCubit = BlocProvider.of<MagazineCubit>(context);
    _magazineCubit.getMainMagazines();
    _magazineCubit.getCatalogMagazine();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MagazineCubit, MagazineState>(builder: (context, state) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (state.todaysMagazines != null)
              LeftPageWire(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child:
                      TodaysMagazine(todaysMagazines: state.todaysMagazines!)),
            LeftPageWire(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
                      Container(
                          margin: EdgeInsets.only(top: Adaptive.dp(10)),
                          height: 5,
                          color: Colors.black,
                          width: double.maxFinite),
                      Container(
                          color: Colors.white,
                          child: Text('Catalog  ',
                              style: Theme.of(context).textTheme.headline5))
                    ]),
                    SizedBox(height: 3),
                    Text('당신에게 좋은 상품만 준비했어요.',
                        style: Theme.of(context).textTheme.subtitle2),
                    SizedBox(height: 20)
                  ]),
            ),
            SizedBox(height: 15),
            if (state.catalogMagazines != null)
              for (var i = 0; i < state.catalogMagazines!.length; i++)
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CatalogScreen(
                                id: state.catalogMagazines![i].id!))),
                    child: CatalogCard(state.catalogMagazines![i], i + 1))
          ]);
    });
  }
}
