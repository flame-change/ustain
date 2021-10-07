import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/magazine/cubit/magazine_scrapped_cubit.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/components/magazine_card_widget.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class MagazineScrappedPage extends StatefulWidget {
  static String routeName = 'magazine_scrapped_page';

  @override
  _MagazineScrappedPageState createState() => _MagazineScrappedPageState();
}

class _MagazineScrappedPageState extends State<MagazineScrappedPage> {
  late MagazineScrappedCubit _magazineScrappedCubit;
  final _scrollController = ScrollController();

  late User user;

  @override
  void initState() {
    super.initState();
    _magazineScrappedCubit = BlocProvider.of<MagazineScrappedCubit>(context);
    _magazineScrappedCubit.getScrappedMagazine();
    _scrollController.addListener(_onScroll);
    user = context.read<AuthenticationBloc>().state.user;
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0) {
      _magazineScrappedCubit.getScrappedMagazine();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MagazineScrappedCubit, MagazineScrappedState>(
        builder: (context, state) {
      if (state.isLoaded) {
        if (state.scrappedMagazines != null) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: Wrap(
              runSpacing: 15,
              children: <Widget>[
                    RichText(
                      text: TextSpan(
                          style:
                              theme.textTheme.headline3!.copyWith(height: 1.5),
                          children: [
                            TextSpan(
                              text: "MY ",
                              style: TextStyle(color: theme.accentColor),
                            ),
                            TextSpan(text: "MAGAZINES"),
                          ]),
                    ),
                  ] +
                  List.generate(
                      state.scrappedMagazines!.length,
                      (index) => magazineCard(
                          context, state.scrappedMagazines![index])),
            ),
          );
        } else {
          return Container(
              height: Adaptive.h(100),
              child: Center(child: Text("스크랩한 매거진이 없어요.")));
        }
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  List<Widget> categoryTitle() {
    return List<Widget>.generate(
        user.categories!.length,
        (index) => GestureDetector(
              onTap: () {
                print(user.categories![index].title);
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                // decoration: BoxDecoration(
                //     color: _magazineCubit.state.magazineCategory ==
                //             user.categories![index]
                //         ? Colors.lightBlue
                //         : Colors.black12,
                //     borderRadius: BorderRadius.circular(25)),
                child: Text(user.categories![index].title!),
              ),
            ));
  }
}
