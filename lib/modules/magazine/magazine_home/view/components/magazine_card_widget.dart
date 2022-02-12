import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/support/style/size_util.dart';
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
                              RepositoryProvider.of<MagazineRepository>(
                                  context)))
                    ], child: MagazineDetailPage(id: magazine.id))));
      },
      child: Column(children: [
        Container(
            width: sizeWidth(45),
            height: sizeWidth(45),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(magazine.bannerImage!)))),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 5),
            child: Text(magazine.title!,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white)))
      ]));
}
