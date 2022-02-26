import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

Widget todaysMagazineCard(BuildContext context, Magazine magazine) {
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
                    ], child: MagazineDetailPage(id: magazine.id!))));
      },
      child: Stack(children: [
        Container(
            height: Adaptive.w(60),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(magazine.bannerImage!)))),
        Container(
            height: Adaptive.w(90),
            padding: EdgeInsets.only(left: 10, right: 10, top: Adaptive.w(65)),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(magazine.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headline5),
                  SizedBox(height: Adaptive.h(1)),
                  WrappedKoreanText(magazine.subtitle!,
                      maxLines: 2, style: theme.textTheme.bodyText2)
                ]))
      ]));
}
