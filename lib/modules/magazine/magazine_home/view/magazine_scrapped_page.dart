import 'package:aroundus_app/modules/magazine/magazine_home/view/components/magazine_card_widget.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_scrapped_cubit.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MagazineScrappedPage extends StatefulWidget {
  static String routeName = 'magazine_scrapped_page';

  @override
  _MagazineScrappedPageState createState() => _MagazineScrappedPageState();
}

class _MagazineScrappedPageState extends State<MagazineScrappedPage>
    with AutomaticKeepAliveClientMixin<MagazineScrappedPage> {
  @override
  bool get wantKeepAlive => true;

  late MagazineScrappedCubit _magazineScrappedCubit;
  final _scrollController = ScrollController();

  late User user;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthenticationBloc>().state.user;
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
          TitleWithUnderline(
              title: "MY MAGAZINES", subtitle: "친구들에게도 공유 해보세요!"),
          if (context.read<AuthenticationBloc>().state.status ==
              AuthenticationStatus.authenticated)
            _magazineScrappedCubit.state.scrappedMagazines != null
                ? _magazineScrappedCubit.state.scrappedMagazines != []
                    ? ListView(
                        shrinkWrap: true,
                        children: List.generate(
                            _magazineScrappedCubit
                                .state.scrappedMagazines!.length,
                            (index) => magazineCard(
                                context,
                                _magazineScrappedCubit
                                    .state.scrappedMagazines![index])),
                      )
                    : Container()
                : Center(child: CircularProgressIndicator())
          else
            LoginNeeded()
        ]));
  }
}
