import 'package:aroundus_app/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:aroundus_app/modules/mypage/user_info/components/achievement_tile.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/mypage/view/components/menu_widgets.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/modules/mypage/cubit/mypage_cubit.dart';
import 'package:aroundus_app/support/base_component/page_wire.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late AuthenticationRepository _authenticationRepository;
  late User user;
  late MypageCubit _mypageCubit;

  @override
  void initState() {
    super.initState();
    _authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    _mypageCubit = BlocProvider.of<MypageCubit>(context);
    user = context.read<AuthenticationBloc>().state.user;
    _mypageCubit.getMypageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          width: double.infinity,
          color: Colors.black,
          child: PageWire(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('${user.name}',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white)),
                Divider(color: Colors.white, thickness: 3),
                Text('LEVEL : ${user.group![0]['level']}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
                SizedBox(height: Adaptive.h(1)),
                userCategories()
              ]))),
      BlocBuilder<MypageCubit, MypageState>(builder: (context, state) {
        if (state.isLoaded == true) {
          return Container(
              color: Colors.white,
              child: PageWire(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(height: Adaptive.h(3)),
                    menuWidget("ACHIEVEMENTS"),
                    SizedBox(height: Adaptive.h(2)),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.grey),
                            children: [
                          TextSpan(text: '등급은 아래의 성취도의 합산으로 계산됩니다.\n'),
                          TextSpan(text: '각 등급에 따라 매월 1일 차등적으로 쿠폰이 지급됩니다.')
                        ])),
                    SizedBox(height: Adaptive.h(3)),
                    AchievementTile(
                        name: '구매 확정',
                        child: Container(
                            width: Adaptive.w(10),
                            height: Adaptive.w(10),
                            child: SvgPicture.asset('assets/icons/success.svg',
                                color: Colors.black)),
                        value: state.orderDone,
                        description: '지난 달에 구매확정된 상품 수 입니다.'),
                    Divider(),
                    AchievementTile(
                        name: '매거진 댓글 수',
                        child: Container(
                            width: Adaptive.w(10),
                            height: Adaptive.w(10),
                            child: SvgPicture.asset('assets/icons/bookmark.svg',
                                color: Colors.black)),
                        value: state.magReviews,
                        description: '매거진에 남기신 댓글 수 입니다.'),
                    Divider(),
                    AchievementTile(
                        name: '상품 리뷰 수',
                        child: Container(
                            width: Adaptive.w(10),
                            height: Adaptive.w(10),
                            child: SvgPicture.asset('assets/icons/cart.svg',
                                color: Colors.black)),
                        value: state.orderReviews,
                        description: '작성해주신 상품 리뷰 수 입니다.')
                  ])));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
      Container(
          color: Colors.grey.shade100,
          padding: EdgeInsets.symmetric(
              vertical: Adaptive.h(3), horizontal: sizeWidth(3)),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                TextSpan(
                    text: '유의사항\n\n',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.grey)),
                TextSpan(text: '해당 수치는 객월 고객님의 활동을 근거로 반영합니다.\n'),
                TextSpan(
                    text:
                        '서비스 이용약관에 기술되어 있듯, 구매 후 3주가 지난 이후 취소, 환불 요청이 없는 경우에는 자동적으로 구매확정 처리됩니다.\n'),
                TextSpan(text: '구매확정 시기는 물품을 구입한 시기와 상이합니다.')
              ])))
    ]));
  }

  RichText userCategories() {
    return RichText(
        text: TextSpan(children: [
      for (var category in user.selectedCategories!)
        WidgetSpan(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(sizeWidth(5))),
                child: Text(category.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white))))
    ]));
  }
}
