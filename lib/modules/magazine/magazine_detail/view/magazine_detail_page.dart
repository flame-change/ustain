import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'components/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MagazineDetailPage extends StatefulWidget {
  final int? id;
  final bool isNotice;

  MagazineDetailPage({this.id, this.isNotice = false});

  @override
  _MagazineDetailPageState createState() => _MagazineDetailPageState();
}

class _MagazineDetailPageState extends State<MagazineDetailPage>
    with SingleTickerProviderStateMixin {
  int get _id => this.widget.id!;
  late MagazineDetailCubit _magazineDetailCubit;
  late User user;
  late AuthenticationStatus user_status;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthenticationBloc>().state.user;
    user_status = context.read<AuthenticationBloc>().state.status;
    _magazineDetailCubit = BlocProvider.of<MagazineDetailCubit>(context);
    _magazineDetailCubit.getMagazineDetail(_id);
    if (widget.isNotice == false) {
      if (context.read<AuthenticationBloc>().state.status ==
          AuthenticationStatus.authenticated) {
        _magazineDetailCubit.getIsScrapped(_id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return BlocBuilder<MagazineDetailCubit, MagazineDetailState>(
        builder: (context, state) {
      if (state.magazineDetail != null) {
        return Scaffold(
            resizeToAvoidBottomInset: true,
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                  backgroundColor: Colors.transparent,
                  leading: GestureDetector(
                      child: Icon(Icons.arrow_back_ios_outlined),
                      onTap: () => Navigator.pop(context)),
                  pinned: false,
                  snap: false,
                  floating: false,
                  expandedHeight:
                      Adaptive.h(50) - AppBar().preferredSize.height,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Stack(fit: StackFit.expand, children: [
                    Image.network(state.magazineDetail!.bannerImage!,
                        fit: BoxFit.cover,
                        width: sizeWidth(100),
                        height: Adaptive.h(50)),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            width: sizeWidth(100),
                            height: 200,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter,
                                    colors: [
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0),
                                  Theme.of(context).scaffoldBackgroundColor
                                ])))),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${state.magazineDetail!.title}",
                                  style: Theme.of(context).textTheme.headline4),
                              SizedBox(height: 10),
                              Text("${state.magazineDetail!.subtitle}",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(height: 10),
                              if (widget.isNotice == false)
                                getCategories(state.magazineDetail!.categories!)
                            ]))
                  ]))),
              SliverToBoxAdapter(
                  child: SafeArea(
                      top: false,
                      child: Container(
                          width: sizeWidth(100),
                          padding: EdgeInsets.only(
                              left: sizeWidth(5), right: sizeWidth(5), top: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Html(
                                    data: state.magazineDetail!.content,
                                    shrinkWrap: true,
                                    customImageRenders: {
                                      networkSourceMatcher():
                                          networkImageRender(
                                              loadingWidget: () => Container(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor))
                                    }),
                                if (state.magazineDetail!.products!.length != 0)
                                  Divider(),
                                if (state.magazineDetail!.products!.length != 0)
                                  productCard(
                                      context, state.magazineDetail!.products!)
                              ]))))
            ]),
            floatingActionButton:
                widget.isNotice == false ? scrapActionButton() : null);
      } else {
        return Scaffold(
            body: Center(
                child: Image.asset('assets/images/indicator.gif',
                    width: 100, height: 100)));
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
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(30)),
                child: Text("${user.categoryTransfer(categories[index])}",
                    style: TextStyle(
                        color: Colors.white, fontSize: Adaptive.dp(10))))));
  }

  FloatingActionButton scrapActionButton() {
    return FloatingActionButton(
        onPressed: () {
          if (user_status != AuthenticationStatus.authenticated) {
            context.read<MagazineDetailCubit>().updateIsScrapped(widget.id!);
            context.read<MagazineDetailCubit>().getMagazineDetail(widget.id!);
          } else {
            showLoginNeededDialog(context);
          }
        },
        backgroundColor: Colors.black54,
        child: Icon(
            user_status != AuthenticationStatus.authenticated
                ? context.read<MagazineDetailCubit>().state.isScrapped!
                    ? Icons.bookmark
                    : Icons.bookmark_outline_rounded
                : Icons.bookmark_outline_rounded,
            color: Colors.white));
  }
}
