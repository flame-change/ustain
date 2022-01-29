import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'components/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
  late WebViewController _webViewController;
  bool isLoading = true;
  late double webHeight;

  @override
  void initState() {
    super.initState();
    webHeight = Adaptive.h(50);
    user = context.read<AuthenticationBloc>().state.user;
    _magazineDetailCubit = BlocProvider.of<MagazineDetailCubit>(context);
    _magazineDetailCubit.getMagazineDetail(_id);
    if (widget.isNotice == false) {
      if (context.read<AuthenticationBloc>().state.status ==
          AuthenticationStatus.authenticated) {
        _magazineDetailCubit.getIsLike(_id);
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
            bottomNavigationBar: widget.isNotice == false
                ? magazineBottomNavigator(id: _id)
                : null,
            body: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
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
                        color: Colors.black12,
                        colorBlendMode: BlendMode.multiply,
                        fit: BoxFit.cover,
                        width: sizeWidth(100),
                        height: Adaptive.h(50)),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${state.magazineDetail!.title}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.white)),
                              SizedBox(height: 10),
                              Text("${state.magazineDetail!.subtitle}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white)),
                              SizedBox(height: 10),
                              if (widget.isNotice == false)
                                getCategories(state.magazineDetail!.categories!)
                            ]))
                  ]))),
              SliverToBoxAdapter(
                  child: Container(
                      height: webHeight,
                      child: WebView(
                          onPageFinished: (_) async {
                            double height = double.parse(
                                await _webViewController.evaluateJavascript(
                                    "document.documentElement.scrollHeight;"));
                            setState(() {
                              webHeight = height;
                            });
                          },
                          onWebViewCreated: (_controller) {
                            _webViewController = _controller;
                          },
                          initialUrl: state.magazineDetail!.magazineUrl,
                          javascriptMode: JavascriptMode.unrestricted))),
              SliverToBoxAdapter(
                  child: Column(children: [
                state.magazineDetail!.products!.length != 0
                    ? Divider()
                    : SizedBox(height: 0),
                state.magazineDetail!.products!.length != 0
                    ? productCard(context, state.magazineDetail!.products!)
                    : SizedBox(height: 0)
              ]))
            ]));
      } else {
        return Scaffold(
            body: Center(child: Image.asset('assets/images/indicator.gif')));
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
                child: Text("${user.categoryTransfer(categories[index])}",
                    style: theme.textTheme.bodyText2!
                        .copyWith(color: Colors.white)))));
  }
}
