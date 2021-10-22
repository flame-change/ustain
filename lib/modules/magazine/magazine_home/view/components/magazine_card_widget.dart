import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

Widget magazineCard(BuildContext context, Magazine magazine) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(providers: [
                BlocProvider<MagazineDetailCubit>(
                  create: (context) => MagazineDetailCubit(
                      RepositoryProvider.of<MagazineRepository>(context)),
                )
              ], child: MagazineDetailPage(magazine.id!)),
            ));
      },
      child: Card(
          elevation: 4,
          child: Column(children: [
            Container(
                width: Adaptive.w(100),
                height: Adaptive.h(20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(magazine.bannerImage!)))),
            Container(
                color: Colors.white,
                width: Adaptive.w(100),
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        magazine.title!,
                        maxLines: 2,
                        style: theme.textTheme.headline4,
                      ),
                      Text(
                        magazine.subtitle!,
                        maxLines: 2,
                        style: theme.textTheme.bodyText2!
                            .copyWith(fontWeight: FontWeight.w400),
                      )
                    ]))
          ])));
}
