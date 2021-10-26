import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/modules/store/store_home/view/view.dart';
import 'package:aroundus_app/repositories/store_repository/src/store_repository.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreHomeScreen extends StatefulWidget {
  static String routeName = 'store_home_screen';

  @override
  State<StatefulWidget> createState() => _StoreHomeScreen();
}

class _StoreHomeScreen extends State<StoreHomeScreen>
    with AutomaticKeepAliveClientMixin<StoreHomeScreen> {
  @override
  bool get wantKeepAlive => true;

  late StoreCubit _storeCubit;

  // late Collection currentCollection;
  late User user;

  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _storeCubit = StoreCubit(RepositoryProvider.of<StoreRepository>(context));
    user = context.read<AuthenticationBloc>().state.user;
    // _storeCubit.initMenu(user.collections!.first.collection.first);
    // currentCollection = _storeCubit.state.selectedMenu!;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void goBack() {
    _pageController.previousPage(
        curve: Curves.ease, duration: Duration(milliseconds: 500));
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
    );
  }
}
