import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
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
                    ], child: MagazineDetailPage(id: magazine.id))));
      },
      child: Stack(children: [
        Container(
            width: sizeWidth(100),
            height: sizeWidth(60),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(magazine.bannerImage!)))),
        Positioned(
            bottom: 0,
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                      Colors.black54.withOpacity(0),
                      Colors.black54
                    ])),
                width: sizeWidth(100),
                height: sizeWidth(30))),
        Positioned(
            bottom: 20,
            left: 20,
            child: WrappedKoreanText(magazine.title!,
                maxLines: 2,
                style:
                    theme.textTheme.headline5!.copyWith(color: Colors.white)))
      ]));
}
