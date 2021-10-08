import 'dart:math';

import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
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
  selectedOptions : 사용자가 선택한 옵션
  - 옵션 조합마다 Id값이 유니크해서, type씩 맵핑해줘야함

  quantity : 구매할 옵션의 수량
  */
  late List<TypeGroup> selectedOptions = List.generate(
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
              height: Adaptive.h(10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print(selectedOptions);

                      _productCubit.createCard(
                          _product, selectedOptions, quantity);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("장바구니에 상품이 담겼습니다."),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text("확인"),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                        width: sizeWith(50),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        child: Text("장바구니 담기", style: theme.textTheme.button)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO 오더 쪽 하면 작업
                    },
                    child: Container(
                        color: Colors.black,
                        width: sizeWith(50),
                        alignment: Alignment.center,
                        child: Text(
                          "구매하기",
                          style: theme.textTheme.button!
                              .copyWith(color: Colors.white),
                        )),
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
                              if (selectedOptions[i].variation ==
                                  options[i].variations![j]) {
                                setState(() {
                                  selectedOptions[i] = selectedOptions[i]
                                      .copyWith(
                                          option: selectedOptions[i].option,
                                          variation: null);
                                });
                              } else {
                                setState(() {
                                  selectedOptions[i] = selectedOptions[i]
                                      .copyWith(
                                          option: selectedOptions[i].option,
                                          variation: options[i].variations![j]);
                                });
                              }
                            },
                            height: Adaptive.h(5),
                            elevation: 0,
                            color: selectedOptions[i].variation ==
                                    options[i].variations![j]
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
                      if (quantity > 1) {
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
                      if (quantity < 100) {
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
