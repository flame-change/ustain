import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
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

  @override
  void initState() {
    super.initState();
    _magazineDetailCubit = BlocProvider.of<MagazineDetailCubit>(context);
    _magazineDetailCubit.getMagazineDetail(_id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MagazineDetailCubit, MagazineDetailState>(
        builder: (context, state) {
      if (state.isLoaded) {
        return Scaffold(
          appBar: AppBar(
            title: Text("${state.magazineDetail!.title}"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 50.h,
                  width: 100.w,
                  child: Image.network(
                    "${state.magazineDetail!.bannerImage}",
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
                        "매거진 제목",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold),
                      ),
                      Text("매거진 부제목: 매거진의 부제목",
                          style: TextStyle(fontSize: 20.sp)),
                      getCategories(state.magazineDetail!.categories!),
                      Text("${state.magazineDetail!.createdAt!}"),
                      Divider(),
                      Html(
                        data: state.magazineDetail!.content!,
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
}

Widget getCategories(List<MagazineCategory> categories) {
  return Wrap(
    spacing: 10,
    runSpacing: 5,
    children: List<Widget>.generate(
        categories.length,
        (index) => Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text("${categories[index].name}"),
            )),
  );
}
