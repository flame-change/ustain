import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

class MagazineDetailPage extends StatefulWidget {
  final int id;

  MagazineDetailPage(this.id);

  @override
  _MagazineDetailPageState createState() => _MagazineDetailPageState();
}

class _MagazineDetailPageState extends State<MagazineDetailPage>
    with SingleTickerProviderStateMixin {
  int get _id => this.widget.id;
  late MagazineDetailCubit _magazineDetailCubit;
  final _scrollController = ScrollController();
  late User user;

  @override
  void initState() {
    super.initState();
    _magazineDetailCubit = BlocProvider.of<MagazineDetailCubit>(context);
    _magazineDetailCubit.getMagazineDetail(_id);
    _magazineDetailCubit.getIsLike(_id);
    _scrollController.addListener(_onScroll);
    user = context.read<AuthenticationBloc>().state.user;
  }

  void _onScroll() {
    _magazineDetailCubit.hideNavigation(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MagazineDetailCubit, MagazineDetailState,
            MagazineDetail?>(
        selector: (state) => state.magazineDetail,
        builder: (context, magazineDetail) {
          if (magazineDetail != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text("${magazineDetail.title}"),
                actions: [
                  IconButton(onPressed: () {
                    _magazineDetailCubit.updateIsScrapped(magazineDetail.id!);

                  }, icon: Icon(Icons.archive_outlined))
                ],
              ),
              floatingActionButton: magazineLikeButton(magazineDetail.id!),
              bottomNavigationBar: magazineBottomNavigator(magazineDetail.id!),
              body: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      height: 50.h,
                      width: 100.w,
                      child: Image.network(
                        "${magazineDetail.bannerImage}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    PageWire(
                        child: Container(
                      width: 100.w,
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${magazineDetail.title}",
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                          Text("매거진 부제목: 매거진의 부제목",
                              style: TextStyle(fontSize: 20.sp)),
                          getCategories(magazineDetail.categories!),
                          Text("${magazineDetail.createdAt!}  ${magazineDetail.likeUserCount!}likes"),
                          Divider(),
                          Html(
                            data: magazineDetail.content!,
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget getCategories(List<String> categories) {
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: List<Widget>.generate(
          categories.length,
              (index) => Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.lightBlue,),
            child: Text("${user.fromEng(categories[index])}"),
          )),
    );
  }
}