import 'package:aroundus_app/repositories/store_repository/src/store_repository.dart';
import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/modules/store/store_home/view/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class StoreHomeScreen extends StatefulWidget {
  static String routeName = '/store_home_screen';

  @override
  State<StatefulWidget> createState() => _StoreHomeScreen();
}

class _StoreHomeScreen extends State<StoreHomeScreen>
    with AutomaticKeepAliveClientMixin<StoreHomeScreen> {
  late StoreCubit _storeCubit;
  late Collection currentCollection;

  PageController _pageController = PageController(initialPage: 0);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _storeCubit = StoreCubit(RepositoryProvider.of<StoreRepository>(context));
    _storeCubit.getCollections().whenComplete(() {
      _storeCubit
          .initMenu(_storeCubit.state.collections!.first.collection.first);
      currentCollection = _storeCubit.state.selectedMenu!;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goBack() {
    _pageController.previousPage(
        curve: Curves.ease, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(controller: _pageController, children: [
      BlocProvider.value(
          value: _storeCubit, child: StoreMenuPage(_pageController)),
      BlocProvider.value(value: _storeCubit, child: StorePage(_pageController))
    ]));
  }
}
