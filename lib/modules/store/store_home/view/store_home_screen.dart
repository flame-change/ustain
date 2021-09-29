import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/modules/store/store_home/view/view.dart';
import 'package:aroundus_app/repositories/store_repository/src/store_repository.dart';
import 'package:aroundus_app/support/base_component/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class StoreHomeScreen extends StatefulWidget {
  static String routeName = 'store_home_screen';

  @override
  State<StatefulWidget> createState() => _StoreHomeScreen();
}

class _StoreHomeScreen extends State<StoreHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("스토어",
            style: TextStyle(
                fontSize: Adaptive.sp(25), fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          Icon(Icons.search, size: Adaptive.sp(20)),
          Icon(Icons.notifications, size: Adaptive.sp(20)),
        ],
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) =>
            StoreCubit(RepositoryProvider.of<StoreRepository>(context)),
        child: StorePage(),
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.store),
      floatingActionButton: FloatingActionButton(onPressed: () {

      },
      child: Icon(Icons.shopping_cart_outlined)),
    );
  }
}
