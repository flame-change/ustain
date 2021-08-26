import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_comment_cubit.dart';
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
  int get _magazineId => this.widget.id;

  late MagazineCommentCubit _magazineCommentCubit;
  late User? user;

  final TextEditingController _messageController = TextEditingController();
  final _scrollController = ScrollController();

  FocusNode focusNode = FocusNode();
  MagazineComment? editComment;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthenticationBloc>().state.user;

    _magazineCommentCubit = BlocProvider.of<MagazineCommentCubit>(context);
    _magazineCommentCubit.getMagazineComments(_magazineId);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    focusNode.unfocus();
    editComment = null;
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      child: PageWire(
        child: BlocSelector<MagazineCommentCubit, MagazineCommentState,
            List<MagazineComment>?>(
          selector: (state) => state.comments,
          builder: (context, comments) {
            if (comments != null) {
              return Column(
                children: [
                  Flexible(
                    flex: 9,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: comments.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          commentTile(comments[index]),
                          comments[index].reply != null
                              ? Column(
                                  children: List.generate(
                                    comments[index].reply!.length,
                                    (i) => Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: commentTile(comments[index].reply![i]),
                                    ),
                                  ),
                                )
                              : SizedBox(height: 0)
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      child: messageWidget())
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

  Widget commentTile(MagazineComment comment) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text("${comment.id}"),
      // leading: Image.network('https://via.placeholder.com/80'),
      title: Text("${comment.name} // ${comment.content}"),
      trailing: user!.name == comment.name
          ? InkWell(
              onTap: () {
                _magazineCommentCubit.deleteMagazineComment(comment);
              },
              child: Text("삭제"),
            )
          : SizedBox(
              height: 0,
            ),
      // TODO 날짜 유틸 후 수정
      subtitle: Row(
        children: [
          Text("July 26"),
          InkWell(
            onTap: () {
              focusNode.requestFocus();

              setState(() {
                _messageController.text = "@"+comment.name!+" ";
                editComment = comment;
                print("답글달기 - editComment $editComment");
              });

            },
            child: Text("답글 달기"),
          )
        ],
      ),
    );
  }

  Widget messageWidget() {
    return Container(
        width: 100.w,
        child: TextFormField(
            focusNode: focusNode,
            controller: _messageController,
            onChanged: (value){
              print(value);
            },
            decoration: InputDecoration(
                suffixIcon: MaterialButton(
              onPressed: () {
                if(editComment != null) {
                  String editContent = _messageController.text.trim();

                  editContent = editContent.replaceAll("@"+editComment!.name!+" ", "");
                  print("editContent $editContent");
                  _magazineCommentCubit.requestMagazineComment(_magazineId, editContent, editComment!.parent==null?editComment!.id: editComment!.parent);

                } else {
                  _magazineCommentCubit.requestMagazineComment(_magazineId, _messageController.text, null);
                }
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
}
