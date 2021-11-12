import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'product_purchase_sheet.dart';

Widget productSaleBottomNavigator(
    BuildContext context, ProductCubit _productCubit) {
  return Container(
      height: Adaptive.h(10),
      width: Adaptive.w(100),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: GestureDetector(
          onTap: () {
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
          child: Center(
              child:
                  Text("구매하기", style: Theme.of(context).textTheme.headline5))));
}
