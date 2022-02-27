import 'package:aroundus_app/modules/brands/brand_home/view/brand_screen.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/modules/search/search/view/search_screen.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class StoreMenuPage extends StatefulWidget {
  StoreMenuPage(this.pageController);

  final PageController pageController;

  @override
  State<StatefulWidget> createState() => _StoreMenuPage();
}

class _StoreMenuPage extends State<StoreMenuPage>
    with SingleTickerProviderStateMixin {
  PageController get pageController => this.widget.pageController;

  late StoreCubit _storeCubit;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    _storeCubit.getCollections();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
      if (state.collections != null) {
        return Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
                child: DefaultTabController(
                    length: 2,
                    child: NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return [
                            storeAppBarWidget(),
                            SliverOverlapAbsorber(
                                handle: NestedScrollView
                                    .sliverOverlapAbsorberHandleFor(context),
                                sliver: SliverPersistentHeader(
                                    pinned: true, delegate: TabBarDelegate()))
                          ];
                        },
                        body: storeMenuTabbarWidget()))));
      } else {
        return Center(
            child: Image.asset('assets/images/indicator.gif',
                width: 100, height: 100));
      }
    });
  }

  // 카테고리, 브랜드 분기하는 탭바 부분
  Column storeMenuTabbarWidget() {
    return Column(children: [
      SizedBox(height: 48),
      Expanded(
          child: TabBarView(children: [
        PageWire(
            child: SingleChildScrollView(
                child: Column(
                    children: List.generate(
                        _storeCubit.state.collections!.length,
                        (i) => Column(children: [
                              // 카테고리 제일 큰 거
                              BigCategory(storeCubit: _storeCubit, index: i),
                              // 카테고리 두번째 거
                              ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children:
                                      // 카테고리 두번째 거 로직
                                      mediumCategoryLogic(i)),
                              SizedBox(height: 10)
                            ]))))),
        PageWire(child: BrandScreen())
      ]))
    ]);
  }

  List<Widget> mediumCategoryLogic(int i) {
    return List.generate(
        _storeCubit.state.collections![i].collection.length,
        (j) => GestureDetector(
            onTap: () {
              _storeCubit.selectedCollection(
                  _storeCubit.state.collections![i].collection[j]);
              pageController.animateToPage(1,
                  duration: Duration(milliseconds: 400), curve: Curves.easeOut);
            },
            child:
                mediumCategory(storeCubit: _storeCubit, index1: i, index2: j)));
  }
}

// 스토어 최상단 부분 (store, 검색)
class storeAppBarWidget extends StatelessWidget {
  const storeAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        brightness: Brightness.light,
        centerTitle: false,
        pinned: false,
        floating: true,
        snap: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(
            background: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
                    child: RichText(
                        text: TextSpan(children: [
                      WidgetSpan(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Text('Store',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontWeight: FontWeight.w500)),
                            GestureDetector(
                                child: Icon(Icons.search_outlined,
                                    color: Colors.black, size: Adaptive.dp(25)),
                                onTap: () => Navigator.pushNamed(
                                    context, SearchScreen.routeName))
                          ]))
                    ]))))));
  }
}

// 제일 큰 카테고리 UI
class BigCategory extends StatelessWidget {
  const BigCategory(
      {Key? key, required StoreCubit storeCubit, required this.index})
      : _storeCubit = storeCubit,
        super(key: key);

  final StoreCubit _storeCubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Stack(children: [
          Container(
              margin: EdgeInsets.only(top: Adaptive.dp(10)),
              height: 5,
              color: Colors.black,
              width: double.maxFinite),
          Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Text(
                  "${_storeCubit.state.collections![index].name.toUpperCase()} ",
                  style:
                      theme.textTheme.headline5!.copyWith(letterSpacing: -0.5)))
        ]));
  }
}

// 둘째 카테고리 UI
class mediumCategory extends StatelessWidget {
  const mediumCategory(
      {Key? key,
      required StoreCubit storeCubit,
      required this.index1,
      required this.index2})
      : _storeCubit = storeCubit,
        super(key: key);

  final StoreCubit _storeCubit;
  final int index1;
  final int index2;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Stack(children: [
          Container(
              margin: EdgeInsets.only(top: Adaptive.dp(12)),
              height: 1,
              color: _storeCubit.state.selectedMenu ==
                      _storeCubit.state.collections![index1].collection[index2]
                  ? Colors.black
                  : Colors.grey,
              width: double.maxFinite),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                      "  ${_storeCubit.state.collections![index1].collection[index2].name}",
                      style: theme.textTheme.bodyText1!.copyWith(
                          color: _storeCubit.state.selectedMenu ==
                                  _storeCubit.state.collections![index1]
                                      .collection[index2]
                              ? Colors.black
                              : Colors.grey,
                          fontWeight: _storeCubit.state.selectedMenu ==
                                  _storeCubit.state.collections![index1]
                                      .collection[index2]
                              ? FontWeight.w700
                              : FontWeight.w500))))
        ]));
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: EdgeInsets.only(left: sizeWidth(5)),
                child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: Theme.of(context).textTheme.headline5,
                    isScrollable: true,
                    tabs: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('카테고리')),
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('브랜드'))
                    ],
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: Colors.black),
                        insets: EdgeInsets.only(bottom: -6)),
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.only(right: 20)))));
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
