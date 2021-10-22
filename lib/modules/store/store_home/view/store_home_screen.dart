import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/modules/store/store_home/view/view.dart';
import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/repositories/store_repository/models/menu.dart';
import 'package:aroundus_app/repositories/store_repository/src/store_repository.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/bottom_navbar.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class StoreHomeScreen extends StatefulWidget {
  static String routeName = 'store_home_screen';

  @override
  State<StatefulWidget> createState() => _StoreHomeScreen();
}

class _StoreHomeScreen extends State<StoreHomeScreen> {

  late StoreCubit _storeCubit;
  late Collection currentCollection;

  PageController _pageController =  PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _storeCubit = StoreCubit(RepositoryProvider.of<StoreRepository>(context));
    _storeCubit.initMenu();
    currentCollection = _storeCubit.state.selectedMenu!;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void goBack() {
    _pageController.previousPage(curve: Curves.ease, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          BlocProvider.value(
            value: _storeCubit,
            child: StoreMenuPage(_pageController),
          ),
          BlocProvider.value(
            value: _storeCubit,
            child: StorePage(_pageController),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.store),
    );
  }
}
