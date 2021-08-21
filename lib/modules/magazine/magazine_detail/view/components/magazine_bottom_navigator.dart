import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_comment_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_detail_cubit.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'magazine_comment_sheet.dart';

Widget magazineBottomNavigator(int id) {
  return BlocSelector<MagazineDetailCubit, MagazineDetailState, bool>(
    selector: (state) {
      return !state.isHide;
    },
    builder: (context, isHide) {
      context.read<MagazineDetailCubit>().hideNavigation(true);
      return Visibility(
        visible: !isHide,
        child: Container(
          color: Colors.lightBlue,
          height: 10.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: Wrap(
            runAlignment: WrapAlignment.center,
            spacing: 10,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share,
                    semanticLabel: "공유",
                  ),
                  Text("공유"),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      builder: (context) => BlocProvider<MagazineCommentCubit>(
                            create: (context) => MagazineCommentCubit(
                                RepositoryProvider.of<MagazineRepository>(
                                    context)),
                            child: MagazineCommentSheet(id),
                          ),
                      isScrollControlled: true);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.comment,
                      semanticLabel: "댓글",
                    ),
                    Text("댓글"),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
