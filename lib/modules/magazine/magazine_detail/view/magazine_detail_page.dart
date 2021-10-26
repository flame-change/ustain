import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'components/product_card_widget.dart';

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
  late User user;

  @override
  void initState() {
    super.initState();
    _magazineDetailCubit = BlocProvider.of<MagazineDetailCubit>(context);
    _magazineDetailCubit.getMagazineDetail(_id);
    _magazineDetailCubit.getIsLike(_id);
    user = context.read<AuthenticationBloc>().state.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MagazineDetailCubit, MagazineDetailState,
            MagazineDetail?>(
        selector: (state) => state.magazineDetail,
        builder: (context, magazineDetail) {
          if (magazineDetail != null) {
            return Scaffold(
                bottomNavigationBar:
                    magazineBottomNavigator(context, magazineDetail.id!),
                body: CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                      backgroundColor: Colors.black,
                      leading: IconButton(
                          padding: EdgeInsets.only(left: 30),
                          icon: Icon(Icons.arrow_back_ios_outlined),
                          iconSize: 20,
                          alignment: Alignment.centerLeft,
                          onPressed: () => Navigator.pop(context)),
                      actions: [
                        IconButton(
                            padding: EdgeInsets.only(right: 30),
                            icon: SvgPicture.asset('assets/icons/bookmark.svg'),
                            iconSize: 20,
                            alignment: Alignment.centerLeft,
                            onPressed: () => Navigator.pop(context))
                      ],
                      pinned: false,
                      snap: false,
                      floating: true,
                      expandedHeight:
                          Adaptive.h(50) - AppBar().preferredSize.height,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Stack(children: [
                        Image.network(magazineDetail.bannerImage!,
                            color: Colors.black12,
                            colorBlendMode: BlendMode.multiply,
                            fit: BoxFit.cover,
                            height: Adaptive.h(50)),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${magazineDetail.title}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(color: Colors.white)),
                                  SizedBox(height: 10),
                                  Text(
                                    "${magazineDetail.subtitle}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 10),
                                  getCategories(magazineDetail.categories!)
                                ]))
                      ]))),
                  SliverToBoxAdapter(
                      child: SafeArea(
                          top: false,
                          child: Container(
                              width: Adaptive.w(100),
                              padding: EdgeInsets.only(
                                left: sizeWith(5),
                                right: sizeWith(5),
                                top: 15,
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Html(
                                        data: magazineDetail.content,
                                        shrinkWrap: true),
                                    Divider(),
                                    magazineDetail.products != null
                                        ? productCard(
                                            context, magazineDetail.products!)
                                        : SizedBox(height: 0)
                                  ]))))
                ]));
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
                  decoration: BoxDecoration(color: Colors.black),
                  // child: Text("${user.categoryTransfer(categories[index])}",
                  //     style: theme.textTheme.bodyText2!
                  //         .copyWith(color: Colors.white))
                )));
  }
}
