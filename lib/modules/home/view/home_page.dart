import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/home/components/main_carousel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MagazineCubit _magazineCubit;

  @override
  void initState() {
    super.initState();
    _magazineCubit = BlocProvider.of<MagazineCubit>(context);
    _magazineCubit.getBannerMagazines();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MagazineCubit, MagazineState>(builder: (context, state) {
      return Stack(
          alignment: Alignment.bottomLeft,
          fit: StackFit.expand,
          children: [
            state.bannerMagazines != null
                ? BannerMagazines(state.bannerMagazines!)
                : Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Center(
                        child: Image.asset('assets/images/indicator.gif',
                            width: 100, height: 100)))
          ]);
    });
  }
}
