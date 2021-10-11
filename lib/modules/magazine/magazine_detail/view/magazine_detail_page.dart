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
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: Adaptive.h(50),
                          width: sizeWith(100),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      magazineDetail.bannerImage!))),
                          child: Container(
                              width: 100.w,
                              child: Container(
                                color: Colors.black12,
                              )),
                        ),
                        Container(
                          height: Adaptive.h(50),
                          padding: EdgeInsets.only(
                              left: sizeWith(5),
                              right: sizeWith(5),
                              bottom: 20),
                          child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back_ios_outlined),
                                      iconSize: 20,
                                      alignment: Alignment.centerLeft,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  color: Colors.white,
                                                  height: 1.5),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "${magazineDetail.title}\n",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: Adaptive.dp(20))),
                                            TextSpan(text: "매거진 부제목"),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: getCategories(
                                          magazineDetail.categories!),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SafeArea(
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
                                shrinkWrap: true,
                              ),
                              Divider(),
                              magazineDetail.products != null
                                  ? productCard(
                                  context, magazineDetail.products!)
                                  : SizedBox(height: 0)
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
                  color: Colors.black,
                ),
                child: Text(
                  "${user.categoryTransfer(categories[index])}",
                  style:
                      theme.textTheme.bodyText2!.copyWith(color: Colors.white),
                ),
              )),
    );
  }
}
