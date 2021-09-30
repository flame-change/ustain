import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget storeProduct(Product product) {
  return Container(
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
          padding: EdgeInsets.symmetric(horizontal: sizeWith(4), vertical: 10),
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
  );
}
