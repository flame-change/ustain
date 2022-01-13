import 'package:aroundus_app/modules/magazine/magazine_home/view/components/magazine_card_widget.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_scrapped_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MagazineScrappedPage extends StatefulWidget {
  static String routeName = '/magazine_scrapped_page';

  @override
  _MagazineScrappedPageState createState() => _MagazineScrappedPageState();
}

class _MagazineScrappedPageState extends State<MagazineScrappedPage> {
  late MagazineScrappedCubit _magazineScrappedCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _magazineScrappedCubit = BlocProvider.of<MagazineScrappedCubit>(context);
    if (context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated) {
      _magazineScrappedCubit.getScrappedMagazine();
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0) {
      _magazineScrappedCubit.getScrappedMagazine();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: _scrollController,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LeftPageWire(
            child: TitleWithUnderline(
                title: "MY MAGAZINES", subtitle: "친구들에게도 공유 해보세요!"),
          ),
          if (context.read<AuthenticationBloc>().state.status ==
              AuthenticationStatus.authenticated)
            PageWire(child:
                BlocBuilder<MagazineScrappedCubit, MagazineScrappedState>(
                    builder: (context, state) {
              if (state.isLoaded == true &&
                  state.scrappedMagazines!.length != 0) {
                return Column(children: [
                  ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                          _magazineScrappedCubit
                              .state.scrappedMagazines!.length,
                          (index) => magazineCard(
                              context,
                              _magazineScrappedCubit
                                  .state.scrappedMagazines![index])))
                ]);
              } else if (state.isLoaded == true &&
                  state.scrappedMagazines!.length == 0) {
                return Container(
                    margin: EdgeInsets.only(top: Adaptive.h(3)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200]),
                    height: Adaptive.w(35),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(height: Adaptive.h(1)),
                          Text('스크랩한 매거진이 없습니다.',
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(height: Adaptive.h(1))
                        ]));
              } else {
                return Container(
                    padding: EdgeInsets.only(top: Adaptive.h(15)),
                    color: Colors.white,
                    child: Center(
                        child: Image.asset('assets/images/indicator.gif')));
              }
            }))
          else
            PageWire(child: LoginNeeded())
        ]));
  }
}
