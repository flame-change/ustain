import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget magazineLikeButton(int id) {
  return BlocSelector<MagazineDetailCubit, MagazineDetailState, bool>(
    selector: (state) => state.isLike!,
    builder: (context, isLike) {
       if (isLike != null){
         return FloatingActionButton(
          onPressed: () {
            context.read<MagazineDetailCubit>().updateIsLike(id);
            context.read<MagazineDetailCubit>().getMagazineDetail(id);
          },
          child: isLike
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
        );
      } else {
         return SizedBox(height: 0);
       }
    },
  );
}