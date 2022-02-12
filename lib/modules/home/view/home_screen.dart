import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/home/view/home_page_new.dart';
import 'package:aroundus_app/support/base_component/company_info.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../home.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => MagazineCubit(
                  RepositoryProvider.of<MagazineRepository>(context)))
        ],
        child: SingleChildScrollView(
            child: Column(children: [
          Container(height: Adaptive.h(50), child: HomePage()),
          HomePageNew(),
          CompanyInfo()
        ])));
  }
}
