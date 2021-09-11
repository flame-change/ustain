import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/magazine_repository/src/magazine_repository.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

Widget magazineCard(BuildContext context, Magazine magazine) {

  User user = context.read<AuthenticationBloc>().state.user;

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
    child: Container(
      width: 100.w,
      height: 30.h,
      color: Colors.black38,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20.h,
            width: 100.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(magazine.bannerImage!))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Wrap(
                  runSpacing: 5,
                  spacing: 10,
                  children: List.generate(
                    magazine.categories!.length,
                    (index) => Container(
                      color: Colors.blue,
                      padding: EdgeInsets.all(5),
                      child: Text("#${user.fromEng(magazine.categories![index])}"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            magazine.title!,
            style: TextStyle(fontSize: 20.sp),
          ),
          Text(
            "매거진 내용 최대 두 줄",
            maxLines: 2,
          ),
        ],
      ),
    ),
  );
}
