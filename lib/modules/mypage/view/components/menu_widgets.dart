import 'package:aroundus_app/modules/mypage/external_link/external_link.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget menuWidget(title) {
  return Container(
      width: sizeWidth(100),
      padding: EdgeInsets.only(bottom: Adaptive.h(1)),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 3))),
      child: Text("$title",
          style:
              theme.textTheme.headline3!.copyWith(fontSize: Adaptive.dp(15))));
}

Widget subMenuWidget({String? title, Function()? tapped}) {
  return GestureDetector(
      onTap: tapped,
      child: Container(
          width: sizeWidth(100),
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration:
              BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
          child: Text("$title",
              style: theme.textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w400, fontSize: Adaptive.dp(15)))));
}

Future<dynamic> isWebRouter(BuildContext context, String url) {
  return kIsWeb == false
      ? Navigator.push(
          context, MaterialPageRoute(builder: (_) => ExternalLink(url: url)))
      : launch(url);
}
