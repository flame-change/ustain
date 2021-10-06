import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/modules/store/product/product_detail/view/product_detail_page.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/repositories/product_repository/product_repository.dart';
import 'package:aroundus_app/support/style/size_util.dart';
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
    child: Container(
      margin: EdgeInsets.only(bottom: Adaptive.h(1)),
      height: Adaptive.h(40),
      child: Column(
        children: [
          Container(
            height: Adaptive.h(20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(product.thumbnail!))),
          ),
          Container(
            height: Adaptive.h(17),
            color: Colors.black12,
            padding:
                EdgeInsets.symmetric(horizontal: sizeWith(4), vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${product.name}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: Adaptive.sp(20)),
                ),
                Text("product.summary"),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(product.thumbnail!),
                          radius: 15),
                    ),
                    Text("${product.brand!.name}"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
