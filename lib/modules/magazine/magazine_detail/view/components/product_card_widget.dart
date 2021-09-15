import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/modules/store/product/product_detail/view/product_detail_page.dart';
import 'package:aroundus_app/repositories/product_repository/models/models.dart';
import 'package:aroundus_app/repositories/product_repository/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

Widget productCard(BuildContext context, List<Product> products) {
  return Wrap(
    runSpacing: 20,
    children: <Widget>[
          Text(
            "연관상품",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
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
                  width: 100.w,
                  height: 10.h,
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          height: 10.h,
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
                                                fontSize: 14.sp,
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
                                                    "${products[index].discountRate}% \t",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text:
                                                  "${products[index].originalPrice}원",
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ]),
                                    ),
                                    Text(
                                      "${products[index].discountPrice}원",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp),
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
