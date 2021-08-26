import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_comment_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_detail_cubit.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MagazineCommentSheet extends StatefulWidget {
  final int id;

  MagazineCommentSheet(this.id);

  @override
  _MagazineCommentSheetState createState() => _MagazineCommentSheetState();
}

class _MagazineCommentSheetState extends State<MagazineCommentSheet>
    with SingleTickerProviderStateMixin {
  int get _id => this.widget.id;

  late MagazineCommentCubit _magazineCommentCubit;
  late User? user;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthenticationBloc>().state.user;

    _magazineCommentCubit = BlocProvider.of<MagazineCommentCubit>(context);
    _magazineCommentCubit.getMagazineComments(_id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      child: PageWire(
        child: BlocSelector<MagazineCommentCubit, MagazineCommentState, List<MagazineComment>?>(
          selector: (state) => state.comments,
          builder: (context, comments) {
            if (comments != null) {
              return Column(
                children: [
                  Flexible(
                    flex: 9,
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          commentTile(_magazineCommentCubit, comments[index], user!),
                          comments[index].reply != null
                              ? Column(
                                  children: List.generate(
                                    comments[index].reply!.length,
                                    (i) => Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: commentTile(_magazineCommentCubit,
                                          comments[index].reply![i],
                                          user!),
                                    ),
                                  ),
                                )
                              : SizedBox(height: 0)
                        ],
                      ),
                    ),
                  ),
                  Flexible(child: messageWidget(_id, _magazineCommentCubit))
                ],
              );
            } else {
              return Center(child: Text("잠시만 기다려주세요."));
            }
          },
        ),
      ),
    );
  }
}

Widget commentTile(MagazineCommentCubit magazineCommentCubit, MagazineComment comment, User user) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Image.network('https://via.placeholder.com/80'),
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text("${comment.name}"),
        ),
        Text("${comment.content}")
      ],
    ),
    trailing: user.name == comment.name
        ? Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {},
          child: Text("편집"),
        ),
        InkWell(
          onTap: () {
            magazineCommentCubit.deleteMagazineComment(comment);
          },
          child: Text("삭제"),
        )
      ],
    )
        : SizedBox(
            height: 0,
          ),
    // TODO 날짜 유틸 후 수정
    subtitle: Text("July 26"),
  );
}

Widget messageWidget(
    int magazineId, MagazineCommentCubit _magazineCommentCubit) {
  final TextEditingController _messageController = TextEditingController();

  return Container(
      width: 100.w,
      child: TextFormField(
          controller: _messageController,
          decoration: InputDecoration(
              suffixIcon: MaterialButton(
            onPressed: () {
              _magazineCommentCubit.requestMagazineComment(
                  magazineId, _messageController.text, null);
            },
            minWidth: 60,
            height: 60,
            color: Colors.grey,
            child: Icon(
              Icons.send,
              size: 25,
              color: Colors.white,
            ),
          ))));
}
