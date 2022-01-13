import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/modules/search/search/view/search_screen.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
      if (state.collections != null) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: false,
                title: Container(
                    width: sizeWidth(100),
                    child: Text("카테고리",
                        style: theme.textTheme.headline3!
                            .copyWith(fontSize: Adaptive.dp(20)))),
                actions: [
                  GestureDetector(
                      child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:
                              Icon(Icons.search_outlined, color: Colors.black)),
                      onTap: () =>
                          Navigator.pushNamed(context, SearchScreen.routeName))
                ]),
            body: PageWire(
                child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            _storeCubit.state.collections!.length,
                            (i) => Column(children: [
                                  // 카테고리 제일 큰 거
                                  BigCategory(
                                      storeCubit: _storeCubit, index: i),

                                  // 카테고리 두번째 거
                                  ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children:
                                          // 카테고리 두번째 거 로직
                                          mediumCategoryLogic(i))
                                ]))))));
      } else {
        return Center(child: Image.asset('assets/images/indicator.gif'));
      }
    });
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
        padding: EdgeInsets.only(top: 15, bottom: 5),
        child: Stack(children: [
          Container(
              margin: EdgeInsets.only(top: Adaptive.dp(10)),
              height: 5,
              color: Colors.black,
              width: double.maxFinite),
          Container(
              color: Colors.white,
              child: Text(
                  "${_storeCubit.state.collections![index].name.toUpperCase()} ",
                  style: theme.textTheme.headline4!
                      .copyWith(fontWeight: FontWeight.w700)))
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
        padding: EdgeInsets.symmetric(vertical: Adaptive.h(1)),
        child: Stack(children: [
          Container(
              margin: EdgeInsets.only(top: Adaptive.dp(10)),
              height: 1,
              color: Colors.black,
              width: double.maxFinite),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  color: Colors.white,
                  child: Text(
                      "  ${_storeCubit.state.collections![index1].collection[index2].name}",
                      style: theme.textTheme.bodyText1!.copyWith(
                          color: _storeCubit.state.selectedMenu ==
                                  _storeCubit.state.collections![index1]
                                      .collection[index2]
                              ? theme.accentColor
                              : Colors.black,
                          fontWeight: FontWeight.w500))))
        ]));
  }
}
