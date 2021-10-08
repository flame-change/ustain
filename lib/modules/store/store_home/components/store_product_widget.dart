import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/modules/store/product/product_detail/view/product_detail_page.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/repositories/product_repository/product_repository.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget storeProduct(BuildContext context, Product product) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => BlocProvider<ProductCubit>(
                    create: (_) => ProductCubit(
                        RepositoryProvider.of<ProductRepository>(context)),
                    child: ProductDetailPage(product.Id!),
                  )));
    },
    child: GridTile(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(product.thumbnail!))),
      ),
      footer: Container(
        height: Adaptive.h(15),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: sizeWith(4), vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  style: theme.textTheme.bodyText1!.copyWith(height: 1.3),
                  children: [
                    TextSpan(
                        text: "${product.brand!.name}\n",
                        style: theme.textTheme.subtitle1!.copyWith(
                            fontSize: Adaptive.dp(10),
                            color: Color(0xFF979797))),
                    TextSpan(
                        text: "${product.name}",
                        style: theme.textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: Adaptive.dp(15))),
                  ]),
            ),
            // Text("키워드1"),
            RichText(
              text: TextSpan(
                  style: theme.textTheme.bodyText2!
                      .copyWith(height: 1.3, fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                        text: "${product.discountRate}%\n",
                        style: theme.textTheme.bodyText2!.copyWith(
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700)),
                    TextSpan(
                      text:
                          "${currencyFromString(product.discountPrice.toString())}\t",
                    ),
                    TextSpan(
                        text:
                            "${currencyFromString(product.originalPrice.toString())}",
                        style: theme.textTheme.bodyText2!.copyWith(
                            decoration: TextDecoration.lineThrough,
                            fontSize: Adaptive.dp(9),
                            color: Color(0xFF767676))),
                  ]),
            )
          ],
        ),
      ),
    ),
  );
}
