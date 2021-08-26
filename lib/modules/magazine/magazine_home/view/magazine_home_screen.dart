import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/magazine_home_page.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/base_component/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MagazineHomeScreen extends StatefulWidget {
  static String routeName = 'magazine_home_screen';

  @override
  State<StatefulWidget> createState() => _MagazineHomeScreen();
}

class _MagazineHomeScreen extends State<MagazineHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("매거진",
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          Icon(Icons.notifications, size: 20.sp),
        ],
        elevation: 0,
      ),
        body: BlocProvider(
            create: (_) => MagazineCubit(
                RepositoryProvider.of<MagazineRepository>(context)),
            child: PageWire(child: MagazineHomePage())),
        bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.magazine));
  }
}
