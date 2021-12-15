import 'package:aroundus_app/modules/store/product/product_detail/view/product_detail_page.dart';
import 'package:aroundus_app/repositories/product_repository/product_repository.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

Widget storeProduct(BuildContext context, Product product) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider<ProductCubit>(
                    create: (_) => ProductCubit(
                        RepositoryProvider.of<ProductRepository>(context)),
                    child: ProductDetailPage(product.Id!))));
      },
      child: GridTile(
          child: Container(),
          header: Image.network(product.thumbnail!,
              fit: BoxFit.cover, height: sizeWidth(45) - 2.5),
          footer: Container(
              height: sizeWidth(33),
              color: Colors.white,
              padding:
                  EdgeInsets.symmetric(horizontal: sizeWidth(1), vertical: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      WidgetSpan(
                          child: Text("${product.brand!.name}",
                              style: theme.textTheme.subtitle1!.copyWith(
                                  fontSize: Adaptive.dp(10),
                                  color: Color(0xFF979797)),
                              maxLines: 1)),
                      TextSpan(
                          text: "\n",
                          style: theme.textTheme.subtitle1!
                              .copyWith(fontSize: Adaptive.dp(10))),
                      WidgetSpan(
                          child: Text("${product.name}",
                              style: theme.textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Adaptive.dp(15)),
                              maxLines: 2))
                    ])),
                    SizedBox(height: Adaptive.dp(5)),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "${product.discountRate}%\n",
                          style: theme.textTheme.bodyText2!.copyWith(
                              color: theme.accentColor,
                              fontWeight: FontWeight.w700)),
                      WidgetSpan(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text(
                                "${currencyFromString(product.discountPrice.toString())}\t"),
                            Text(
                                "${currencyFromString(product.originalPrice.toString())}",
                                style: theme.textTheme.bodyText2!.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: Adaptive.dp(8),
                                    color: Color(0xFF767676)))
                          ]))
                    ]))
                  ]))));
}
