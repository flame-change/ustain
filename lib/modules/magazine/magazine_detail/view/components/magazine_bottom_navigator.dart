import 'package:aroundus_app/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_comment_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_detail_cubit.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'magazine_comment_sheet.dart';

class magazineBottomNavigator extends StatefulWidget {
  magazineBottomNavigator({this.id});

  final int? id;

  @override
  _magazineBottomNavigatorState createState() =>
      _magazineBottomNavigatorState();
}

class _magazineBottomNavigatorState extends State<magazineBottomNavigator> {
  late AuthenticationStatus user_status;
  late MagazineDetailCubit _magazineDetailCubit;

  @override
  void initState() {
    super.initState();
    _magazineDetailCubit = BlocProvider.of<MagazineDetailCubit>(context);
    _magazineDetailCubit.getMagazineDetail(widget.id!);
    user_status = context.read<AuthenticationBloc>().state.status;

    if (user_status == AuthenticationStatus.authenticated) {
      _magazineDetailCubit.getIsLike(widget.id!);
      _magazineDetailCubit.getIsScrapped(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Adaptive.h(10),
        width: Adaptive.w(100),
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1)),
        child: Wrap(
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              user_status != AuthenticationStatus.authenticated
                  ? IconButton(
                      onPressed: () => showLoginNeededDialog(context),
                      icon:
                          Icon(Icons.favorite_border, color: theme.accentColor))
                  : IconButton(
                      onPressed: () async {
                        await context
                            .read<MagazineDetailCubit>()
                            .updateIsLike(widget.id!);
                        await context
                            .read<MagazineDetailCubit>()
                            .getMagazineDetail(widget.id!);
                      },
                      icon: context.read<MagazineDetailCubit>().state.isLike!
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      color: theme.accentColor),
              user_status != AuthenticationStatus.authenticated
                  ? IconButton(
                      onPressed: () => showLoginNeededDialog(context),
                      icon: Icon(Icons.bookmark_outline_rounded,
                          color: theme.accentColor))
                  : IconButton(
                      onPressed: () {
                        context
                            .read<MagazineDetailCubit>()
                            .updateIsScrapped(widget.id!);
                        context
                            .read<MagazineDetailCubit>()
                            .getMagazineDetail(widget.id!);
                      },
                      icon:
                          context.read<MagazineDetailCubit>().state.isScrapped!
                              ? Icon(Icons.bookmark)
                              : Icon(Icons.bookmark_outline_rounded),
                      color: theme.accentColor),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share, semanticLabel: "공유"),
                  color: theme.accentColor),
              Container(width: 1, height: Adaptive.h(6), color: Colors.black38),
              MaterialButton(
                  onPressed: () => user_status ==
                          AuthenticationStatus.authenticated
                      ? showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          builder: (context) =>
                              BlocProvider<MagazineCommentCubit>(
                                  create: (context) => MagazineCommentCubit(
                                      RepositoryProvider.of<MagazineRepository>(
                                          context)),
                                  child: MagazineCommentSheet(widget.id!)),
                          isScrollControlled: true)
                      : showLoginNeededDialog(context),
                  child: Text("댓글 달기", style: TextStyle(color: Colors.white)),
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(
                      vertical: Adaptive.h(2), horizontal: Adaptive.w(8)))
            ]));
  }
}
