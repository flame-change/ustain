import 'package:aroundus_app/modules/magazine/magazine_home/view/components/magazine_card_widget.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_scrapped_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/support/style/size_util.dart';
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
          SizedBox(height: 15),
          if (context.read<AuthenticationBloc>().state.status ==
              AuthenticationStatus.authenticated)
            LeftPageWire(child:
                BlocBuilder<MagazineScrappedCubit, MagazineScrappedState>(
                    builder: (context, state) {
              if (state.isLoaded == true &&
                  state.scrappedMagazines!.length != 0) {
                return Column(children: [
                  GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.7,
                      children: List.generate(
                          _magazineScrappedCubit
                              .state.scrappedMagazines!.length,
                          (index) => Padding(
                                padding: EdgeInsets.only(right: sizeWidth(5)),
                                child: magazineCard(
                                    context,
                                    _magazineScrappedCubit
                                        .state.scrappedMagazines![index]),
                              )))
                ]);
              } else if (state.isLoaded == true &&
                  state.scrappedMagazines!.length == 0) {
                return Container(
                    padding: EdgeInsets.only(right: sizeWidth(5)),
                    height: 200,
                    width: double.infinity,
                    child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Icon(Icons.info_outline, color: Colors.black),
                          SizedBox(height: 5),
                          Text('관심 있는 분야를 읽어보고',
                              style: Theme.of(context).textTheme.bodyText2),
                          Text('스크랩에 보관해보세요.',
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(height: Adaptive.h(1))
                        ])));
              } else {
                return Container(
                    padding: EdgeInsets.only(top: Adaptive.h(15)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Center(
                        child: Image.asset('assets/images/indicator.gif',
                            width: 100, height: 100)));
              }
            }))
          else
            PageWire(child: LoginNeeded())
        ]));
  }
}
