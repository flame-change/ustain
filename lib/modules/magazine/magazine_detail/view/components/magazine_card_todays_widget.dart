import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

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
            ], child: MagazineDetailPage(magazine.id!)),
          ));
    },
    child: Stack(
      children: [
        Container(
          width: sizeWith(100),
          height: Adaptive.h(40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(1, 1),
                ),
              ],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(magazine.bannerImage!))),
        ),
        Container(
          width: sizeWith(100),
          height: Adaptive.h(40),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(magazine.title!,
                  style: theme.textTheme.headline3!.copyWith(
                      fontSize: Adaptive.dp(20),
                      height: 2,
                      color: Colors.white)),
              Text(
                magazine.content!,
                maxLines: 2,
                style: theme.textTheme.bodyText1!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
