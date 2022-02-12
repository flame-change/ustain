import 'package:aroundus_app/main.dart';
import 'package:aroundus_app/modules/store/product/product_detail/view/product_detail_page.dart';
import 'package:aroundus_app/modules/brands/brand_detail/cubit/brand_detail_cubit.dart';
import 'package:aroundus_app/repositories/brand_repository/src/brand_repository.dart';
import 'package:aroundus_app/repositories/product_repository/product_repository.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/product_repository/models/models.dart';
import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget productCard(BuildContext context, List<Map> mapProducts) {
  List<Product> products = mapProducts
      .map((p) => Product(
          Id: p["Id"],
          name: p["name"],
          description: p["description"],
          rating: p["rating"],
          originalPrice: p["originalPrice"],
          discountPrice: p["discountPrice"],
          discountRate: p["discountRate"],
          thumbnail: p["thumbnail"]))
      .toList();
  return Wrap(
      children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: sizeWidth(5)),
                child:
                    Text("연관상품", style: Theme.of(context).textTheme.headline5))
          ] +
          List.generate(
              products.length,
              (index) => GestureDetector(
                  onTap: () {
                    moveToProductDetail(context, products, index);
                  },
                  child: productWidget(products: products, index: index))));
}

class productWidget extends StatelessWidget {
  const productWidget({required this.products, required this.index});

  final List<Product> products;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            height: sizeWidth(25),
            width: sizeWidth(25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(products[index].thumbnail!)))),
        SizedBox(width: 10),
        Expanded(
            child: Container(
                constraints: BoxConstraints(minHeight: sizeWidth(25)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${products[index].name}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                  TextSpan(
                                      text:
                                          "${products[index].discountRate}%   ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  TextSpan(
                                      text:
                                          "${currencyFromString(products[index].originalPrice.toString())}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: Adaptive.dp(10),
                                          decoration:
                                              TextDecoration.lineThrough))
                                ])),
                            Text(
                                "${currencyFromString(products[index].discountPrice.toString())}",
                                style: Theme.of(context).textTheme.bodyText1)
                          ])
                    ])))
      ]),
      SizedBox(height: 15)
    ]);
  }
}

Future<dynamic> moveToProductDetail(
    BuildContext context, List<Product> products, int index) {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: BlocProvider.of<AuthenticationBloc>(context),
                child: MultiBlocProvider(providers: [
                  BlocProvider<ProductCubit>(
                      create: (_) => ProductCubit(
                          RepositoryProvider.of<ProductRepository>(context))),
                  BlocProvider<BrandDetailCubit>(
                      create: (_) => BrandDetailCubit(
                          RepositoryProvider.of<BrandRepository>(context)))
                ], child: ProductDetailPage(products[index].Id!)),
              )));
}
