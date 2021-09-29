import 'dart:math';

import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductPurchaseSheet extends StatefulWidget {
  @override
  _ProductPurchaseSheetState createState() => _ProductPurchaseSheetState();
}

class _ProductPurchaseSheetState extends State<ProductPurchaseSheet> {
  late ProductCubit _productCubit;
  late Product _product;

  @override
  void initState() {
    super.initState();
    _productCubit = BlocProvider.of<ProductCubit>(context);
    _product = _productCubit.state.products!.first;
  }


  /*
  pickOption : 사용자가 선택한 옵션
  - 옵션 조합마다 Id값이 유니크해서, type씩 맵핑해줘야함

  quantity : 구매할 옵션의 수량
  */
  late List<TypeGroup> pickOption = List.generate(
      _product.options!.length,
      (index) => TypeGroup(
          option: Option(
              Id: _product.options![index].Id,
              name: _product.options![index].name)));

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adaptive.h(45),
      padding: EdgeInsets.only(top: Adaptive.h(5)),
      child:
          BlocBuilder<ProductCubit, ProductState>(builder: (context, comments) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PageWire(
              child: Wrap(
                  runSpacing: 15,
                  children:
                      optionPurchase(_product.options!) + productQuantity()),
            ),
            Container(
              height: Adaptive.h(5),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        color: Colors.cyanAccent,
                        width: Adaptive.w(100) > 475
                            ? 475 / 100 * 50
                            : Adaptive.w(50),
                        alignment: Alignment.center,
                        child: Text("장바구니 담기")),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        color: Colors.cyan,
                        width: Adaptive.w(100) > 475
                            ? 475 / 100 * 50
                            : Adaptive.w(50),
                        alignment: Alignment.center,
                        child: Text("구매하기")),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  List<Widget> optionPurchase(List<Option> options) {
    return List.generate(
        options.length,
        (i) => Container(
              width: Adaptive.w(100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${options[i].name}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Adaptive.sp(15)),
                  ),
                  Container(
                    height: Adaptive.h(5),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: options[i].variations!.length,
                      itemBuilder: (context, j) => Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: MaterialButton(
                            onPressed: () {
                              if (pickOption[i].variation ==
                                  options[i].variations![j]) {
                                setState(() {
                                  pickOption[i] = pickOption[i].copyWith(
                                      option: pickOption[i].option, variation: null);
                                });
                              } else {
                                setState(() {
                                  pickOption[i] = pickOption[i].copyWith(
                                      option: pickOption[i].option,
                                      variation: options[i].variations![j]);
                                });
                              }
                            },
                            height: Adaptive.h(5),
                            elevation: 0,
                            color: pickOption[i].variation == options[i].variations![j]
                                ? Colors.amber
                                : Colors.grey,
                            child: Text("${options[i].variations![j].value}")),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  List<Widget> productQuantity() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "수량",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: Adaptive.sp(15)),
          ),
          Container(
            height: Adaptive.h(5),
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity>1){
                        quantity -= 1;
                      }
                    });
                  },
                ),
                Text("$quantity"),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (quantity<100){
                        quantity += 1;
                      }
                    });
                  },
                ),
              ],
            ),
          )
        ],
      )
    ];
  }
}
