import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/magazine_card_widget.dart';
import 'package:flutter/material.dart';

class MagazineHomePage extends StatefulWidget {
  static String routeName = '/magazine_home_page';

  @override
  _MagazineHomePageState createState() => _MagazineHomePageState();
}

class _MagazineHomePageState extends State<MagazineHomePage> {
  late MagazineCubit _magazineCubit;
  late User user;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _magazineCubit = BlocProvider.of<MagazineCubit>(context);
    _scrollController.addListener(_onScroll);
    user = context.read<AuthenticationBloc>().state.user;
    getMagazineMethods(context);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0) {
      _magazineCubit.getMagazinesByCategory(
          magazineCategory: _magazineCubit.state.magazineCategory);
    }
  }

  void getMagazineMethods(BuildContext context) {
    _magazineCubit.getMagazinesByCategory(
        magazineCategory: MagazineCategory.empty);
    _magazineCubit.getMainMagazines();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(child:
          BlocBuilder<MagazineCubit, MagazineState>(builder: (context, state) {
        if (state.todaysMagazines != null && state.magazines != null) {
          return Column(children: [
            LeftPageWire(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Wrap(runSpacing: 15, children: [
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      height: 35,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: categoryTitle())),
                  GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.7,
                      children: List.generate(
                          state.magazines!.length,
                          (index) => Padding(
                              padding: EdgeInsets.only(right: sizeWidth(5)),
                              child: magazineCard(
                                  context, state.magazines![index]))))
                ]))
          ]);
        } else {
          return Container(
              padding: EdgeInsets.only(top: Adaptive.h(20)),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                  child: Image.asset('assets/images/indicator.gif',
                      width: 100, height: 100)));
        }
      }))
    ]);
  }

  List<Widget> categoryTitle() {
    return <Widget>[
          GestureDetector(
              onTap: () {
                _magazineCubit.getMagazinesByCategory(
                    magazineCategory: MagazineCategory.empty);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: _magazineCubit.state.magazineCategory ==
                              MagazineCategory.empty
                          ? Colors.black
                          : Theme.of(context).scaffoldBackgroundColor,
                      child: Text("전체보기",
                          style: TextStyle(
                              color: _magazineCubit.state.magazineCategory ==
                                      MagazineCategory.empty
                                  ? Colors.white
                                  : Colors.grey)))))
        ] +
        List<Widget>.generate(
            user.categories!.length,
            (index) => GestureDetector(
                onTap: () => _magazineCubit.getMagazinesByCategory(
                    magazineCategory: user.categories![index]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        alignment: Alignment.center,
                        color: _magazineCubit.state.magazineCategory ==
                                user.categories![index]
                            ? Colors.black
                            : Theme.of(context).scaffoldBackgroundColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(user.categories![index].mid!,
                            style: TextStyle(
                                color: _magazineCubit.state.magazineCategory ==
                                        user.categories![index]
                                    ? Colors.white
                                    : Colors.grey))))));
  }
}
