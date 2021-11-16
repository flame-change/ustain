import 'package:aroundus_app/repositories/brand_repository/src/brand_repository.dart';
import 'package:aroundus_app/modules/brands/brand_home/cubit/brand_cubit.dart';
import 'package:aroundus_app/modules/brands/brand_home/view/brand_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BrandScreen extends StatefulWidget {
  static String routeName = 'brand_screen';

  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  BrandCubit(RepositoryProvider.of<BrandRepository>(context))),
        ],
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                centerTitle: false,
                title:
                    Text('브랜드', style: Theme.of(context).textTheme.headline4),
                actions: [
                  GestureDetector(
                      // onTap: () => Navigator.pushNamed(
                      //     context, SettingsScreen.routeNameName),
                      child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.search, color: Colors.black)))
                ]),
            body: BrandPage()));
  }
}
