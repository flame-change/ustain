import 'package:aroundus_app/modules/store/product/product_detail/view/product_detail_page.dart';
import 'package:aroundus_app/repositories/product_repository/product_repository.dart';
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
          summary: p["summary"],
          description: p["description"],
          rating: p["rating"],
          originalPrice: p["originalPrice"],
          discountPrice: p["discountPrice"],
          discountRate: p["discountRate"],
          thumbnail: p["thumbnail"]))
      .toList();
  return Wrap(
    runSpacing: 20,
    children: <Widget>[
          Text(
            "연관상품",
            style: TextStyle(
                fontSize: Adaptive.sp(20), fontWeight: FontWeight.bold),
          )
        ] +
        List.generate(
          products.length,
          (index) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider<ProductCubit>(
                            create: (_) => ProductCubit(
                                RepositoryProvider.of<ProductRepository>(
                                    context)),
                            child: ProductDetailPage(products[index].Id!),
                          )));
            },
            child: Column(
              children: [
                Container(
                  width: sizeWidth(100),
                  height: Adaptive.h(10),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          height: Adaptive.h(10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      products[index].thumbnail!))),
                        ),
                      ),
                      Flexible(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: "${products[index].name}\n",
                                            style: TextStyle(
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                          text: "${products[index].summary}",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ]),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "${products[index].discountRate}%   ",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(15),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text:
                                                  "${currencyFromString(products[index].originalPrice.toString())}",
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ]),
                                    ),
                                    Text(
                                      "${currencyFromString(products[index].discountPrice.toString())}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(20)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
  );
}
