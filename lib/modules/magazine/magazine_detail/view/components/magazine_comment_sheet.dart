import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_comment_cubit.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

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
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adaptive.h(85),
      child: PageWire(
        child: BlocSelector<MagazineCommentCubit, MagazineCommentState,
            List<MagazineComment>?>(
          selector: (state) => state.comments,
          builder: (context, comments) {
            if (comments != null) {
              return Column(
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.black38,
                    ))),
                    child: Text(
                      "댓글",
                      style: theme.textTheme.bodyText1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Flexible(
                    flex: 9,
                    child: comments.isNotEmpty
                        ? ListView.builder(
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
                                            padding: EdgeInsets.only(
                                                left: webPadding()),
                                            child: commentTile(
                                                comments[index].reply![i]),
                                          ),
                                        ),
                                      )
                                    : SizedBox(height: 0)
                              ],
                            ),
                          )
                        : Center(
                            heightFactor: Adaptive.h(100),
                            child: Text("댓글이 없습니다.")),
                  ),
                  Flexible(child: messageWidget())
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
      dense: true,
      contentPadding: EdgeInsets.zero,
      // leading: Text("${comment.id}"),
      leading: Image.network('https://via.placeholder.com/80'),
      title: Text(
        "${comment.name}",
        style: theme.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: user!.name == comment.name
          ? InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("댓글을 삭제하시겠습니까?"),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              _magazineCommentCubit
                                  .deleteMagazineComment(comment);
                              Navigator.pop(context);
                            },
                            child: Text("확인"),
                          ),
                        ],
                      );
                    });
              },
              child: Text("삭제"),
            )
          : SizedBox(
              height: 0,
            ),
      // TODO 날짜 유틸 후 수정
      subtitle: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        runSpacing: 10,
        children: [
          Text(
            "${comment.content}",
            style: theme.textTheme.subtitle2,
          ),
          Row(
            children: [
              Text("${comment.createdAt}  ",
                  style:
                      theme.textTheme.subtitle2!.copyWith(color: Colors.grey)),
              InkWell(
                onTap: () {
                  focusNode.requestFocus();

                  setState(() {
                    editComment = comment;
                  });
                },
                child: Text("답글 달기"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget messageWidget() {
    _messageController.text = "";

    return Container(
        width: 100.w,
        child: TextFormField(
            focusNode: focusNode,
            controller: _messageController,
            decoration: InputDecoration(
                hintText: "메시지를 입력하세요.",
                prefixText:
                    editComment != null ? "@" + editComment!.name! + " " : "",
                suffixIcon: MaterialButton(
                    onPressed: () {
                      if (editComment != null) {
                        String editContent = _messageController.text.trim();

                        _messageController.clear();
                        _magazineCommentCubit.requestMagazineComment(
                            _magazineId,
                            editContent,
                            editComment!.parent == null
                                ? editComment!.id
                                : editComment!.parent);
                        setState(() {
                          editComment = null;
                        });
                      } else {
                        _magazineCommentCubit.requestMagazineComment(
                            _magazineId, _messageController.text, null);
                      }
                    },
                    minWidth: 60,
                    height: 60,
                    child: Text(
                      "등록",
                      style: TextStyle(color: theme.accentColor),
                    )))));
  }
}
