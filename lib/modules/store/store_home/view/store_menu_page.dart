import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
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
        return Scaffold(
            body: PageWire(
                child: SingleChildScrollView(
                    child: Column(children: [
          Container(
              padding: EdgeInsets.only(top: webPadding()),
              width: sizeWith(100),
              child: Text("CATEGORIES",
                  style: theme.textTheme.headline3!
                      .copyWith(fontSize: Adaptive.dp(20)))),
          Column(
              children: List.generate(
                  _storeCubit.state.collections!.length,
                  (i) => Column(children: [
                        Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.symmetric(vertical: Adaptive.h(2)),
                            child: Center(
                                child: Text(
                                    "${_storeCubit.state.collections![i].name.toUpperCase()}",
                                    style: theme.textTheme.headline3!
                                        .copyWith(fontSize: Adaptive.dp(18)))),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide()))),
                        ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                                _storeCubit
                                    .state.collections![i].collection.length,
                                (j) => GestureDetector(
                                    onTap: () {
                                      _storeCubit.selectedCollection(_storeCubit
                                          .state.collections![i].collection[j]);
                                      pageController.animateToPage(1,
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeOut);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Adaptive.h(0.8)),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border:
                                                Border(bottom: BorderSide())),
                                        child: Text(
                                            "${_storeCubit.state.collections![i].collection[j].name}",
                                            style: theme.textTheme.bodyText1!
                                                .copyWith(
                                                    color: _storeCubit.state
                                                                .selectedMenu ==
                                                            _storeCubit
                                                                .state
                                                                .collections![i]
                                                                .collection[j]
                                                        ? theme.accentColor
                                                        : Colors.black))))))
                      ])))
        ]))));
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
