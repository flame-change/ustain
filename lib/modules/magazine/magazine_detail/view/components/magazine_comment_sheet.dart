import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_comment_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_detail_cubit.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
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

  @override
  void initState() {
    super.initState();
    _magazineCommentCubit = BlocProvider.of<MagazineCommentCubit>(context);
    _magazineCommentCubit.getMagazineComments(_id);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
        child: PageWire(
          child: BlocBuilder<MagazineCommentCubit, MagazineCommentState>(
            builder: (context, state) {
              if(state.isLoaded){
                return Column(
                  children: [
                    Flexible(
                      flex: 9,
                      child: ListView.builder(
                        itemCount: state.comments!.length,
                        itemBuilder: (context, index) => commentTile(state.comments![index]),
                      ),
                    ),
                    Flexible(
                      child: messageWidget()
                    )
                  ],
                );
              }else {
                return Center(child: Text("잠시만 기다려주세요."));
              }
            },
      ),
        ),
    );
  }
}

Widget commentTile(MagazineComment comment) {
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
    // TODO 날짜 유틸 후 수정
    subtitle: Text("July 26"),
  );
}

Widget messageWidget() {
  return Container(
    width: 100.w,
    child: TextFormField(
      decoration: InputDecoration(
        suffixIcon: Container(
          width: 60,
          height: 60,
          color: Colors.grey,
          child: Icon(Icons.send, size: 25,),
        )
      )
    )
  );
}