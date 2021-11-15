import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../catalog/view/catalog_page.dart';

class CatalogScreen extends StatefulWidget {
  static String routeName = '/catalog_screen';
  final int id;

  CatalogScreen({required this.id});

  @override
  State<CatalogScreen> createState() => _CatalogScreen();
}

class _CatalogScreen extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) =>
              MagazineCubit(RepositoryProvider.of<MagazineRepository>(context)))
    ], child: CatalogPage(id: widget.id));
  }
}
