import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/modules/home/components/main_carousel.dart';
import 'package:aroundus_app/modules/home/components/catalog.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
  }

  final _images = [
    'assets/images/1.jpg',
    'assets/images/01-full.jpg',
    'assets/images/01-thumbnail.jpg',
    'assets/images/02-full.jpg',
    'assets/images/04-thumbnail.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      // 메인 캐러셀 부분입니다.
      MainCarousel(images: _images),

      // 카탈로그 시작 전
      SliverToBoxAdapter(
          child: Padding(
        padding: EdgeInsets.all(Adaptive.w(5)),
        child: TitleWithUnderline(
            title: "MD's PICK", subtitle: '어스테인 MD의 추천 상품을 모아봤어요.'),
      )),

      // 카탈로그 카드 들어갈 곳
      SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => CatalogCard(index: index + 1),
              childCount: 10))
    ]);
  }
}
