import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'product_purchase_sheet.dart';

Widget productSaleBottomNavigator(
    BuildContext context, ProductCubit _productCubit) {
  return Container(
      height: Adaptive.h(10),
      width: Adaptive.w(100),
      padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Wrap(runAlignment: WrapAlignment.center, spacing: 10, children: [
          SvgPicture.asset('assets/icons/like.svg', color: theme.accentColor),
          SizedBox(width: 20),
          SvgPicture.asset('assets/icons/share.svg', color: theme.accentColor)
        ]),
        Container(
            width: Adaptive.w(45),
            padding:
                EdgeInsets.only(left: Adaptive.w(10), right: Adaptive.w(5)),
            decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.black))),
            child: PlainButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      builder: (context) => BlocProvider<ProductCubit>.value(
                          value: _productCubit, child: ProductPurchaseSheet()),
                      isScrollControlled: true);
                },
                text: "구매하기"))
      ]));
}
