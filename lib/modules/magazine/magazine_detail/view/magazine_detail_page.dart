import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/magazine_detail.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

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
  // late WebViewController _webViewController;
  bool isLoading = true;
  // late double webHeight;

  @override
  void initState() {
    super.initState();
    // webHeight = Adaptive.h(50);
    user = context.read<AuthenticationBloc>().state.user;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
            body: SafeArea(
                child: Stack(children: <Widget>[
          WebView(
              initialUrl: state.magazineDetail!.magazineUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() => isLoading = false);
              }),
          IconButton(
              icon: Icon(Platform.isAndroid
                  ? Icons.arrow_back
                  : Icons.arrow_back_ios_outlined),
              onPressed: () => Navigator.pop(context)),
          if (isLoading)
            Center(child: Image.asset('assets/images/indicator.gif'))
        ])));
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
