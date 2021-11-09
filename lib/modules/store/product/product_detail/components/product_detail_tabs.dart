import 'package:aroundus_app/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.maxChild,
    @required this.minChild,
  });
  final double? minHeight, maxHeight;
  final Widget? maxChild, minChild;

  double? visibleMainHeight, animationVal, width;

  @override
  bool shouldRebuild(SliverHeaderDelegate oldDelegate) => true;
  @override
  double get minExtent => minHeight!;
  @override
  double get maxExtent => max(maxHeight!, minHeight!);

  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;

    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    width = MediaQuery.of(context).size.width;
    visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    animationVal = scrollAnimationValue(shrinkOffset);

    return Container(
        height: visibleMainHeight,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFFFFFFFF),
        child: Stack(children: <Widget>[
          getMinTop(),
          animationVal != 0 ? getMaxTop() : Container(),
        ]));
  }

  Widget getMaxTop() {
    return Positioned(
      bottom: 0.0,
      child: Opacity(
        opacity: animationVal!,
        child: SizedBox(
          height: maxHeight,
          width: width,
          child: maxChild,
        ),
      ),
    );
  }

  Widget getMinTop() {
    return Opacity(
      opacity: 1 - animationVal!,
      child:
          Container(height: visibleMainHeight, width: width, child: minChild),
    );
  }
}

class appbarRow extends StatelessWidget {
  const appbarRow({required this.context, required this.user_status});

  final BuildContext context;
  final AuthenticationStatus user_status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adaptive.h(5),
      padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            child: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            onTap: () => Navigator.of(context).pop()),
        GestureDetector(
            onTap: () => user_status == AuthenticationStatus.authenticated
                ? Navigator.pushNamed(context, 'cart_screen')
                : showLoginNeededDialog(context),
            child: SvgPicture.asset("assets/icons/cart.svg"))
      ]),
    );
  }
}
