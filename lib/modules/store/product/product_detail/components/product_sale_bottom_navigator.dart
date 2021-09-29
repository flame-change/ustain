import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/repositories/product_repository/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'product_purchase_sheet.dart';

Widget productSaleBottomNavigator(
    BuildContext context, ProductCubit _productCubit) {
  return Container(
    color: Colors.lightBlue,
    height: Adaptive.h(10),
    width: Adaptive.w(100),
    padding: EdgeInsets.symmetric(
      horizontal: Adaptive.w(5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          runAlignment: WrapAlignment.center,
          spacing: 10,
          children: [
            Icon(
              Icons.favorite_border_outlined,
              semanticLabel: "공유",
            ),
            Icon(
              Icons.share,
              semanticLabel: "공유",
            ),
            Icon(
              Icons.comment_rounded,
              semanticLabel: "댓글",
            ),
          ],
        ),
        MaterialButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                builder: (context) => BlocProvider<ProductCubit>.value(
                      value: _productCubit,
                      child: ProductPurchaseSheet(),
                    ),
                isScrollControlled: true);
          },
          color: Colors.grey,
          elevation: 0,
          child: Text("구매하기"),
        ),
      ],
    ),
  );
}
