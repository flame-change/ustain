import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/cupertino.dart';
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
  late double modalHeight;

  @override
  void initState() {
    super.initState();
    _productCubit = BlocProvider.of<ProductCubit>(context);
    _product = _productCubit.state.products!.first;
    modalHeight = _product.options!.length * 5 + 20;
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
  int selected = 0;
  bool hasCart = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
        builder: (context, comments) {
      hasCart = !selectedOptions
          .map((e) => e.variation != null)
          .toList()
          .contains(false);

      return Container(
        height: Adaptive.h(65),
        padding: EdgeInsets.only(top: Adaptive.h(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PageWire(
              child: hasCart
                  ? ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                      ),
                      title: Text("옵션 다시 선택하기"),
                      trailing: Icon(Icons.keyboard_arrow_down_sharp),
                      onTap: () {
                        setState(() {
                          selectedOptions = List.generate(
                              _product.options!.length,
                              (index) => TypeGroup(
                                  option: Option(
                                      Id: _product.options![index].Id,
                                      name: _product.options![index].name)));
                        });
                      },
                    )
                  : Wrap(
                      runSpacing: 5,
                      children: optionPurchase(_product.options!)),
            ),
            hasCart
                ? Expanded(
                    child: Container(
                      padding: basePadding(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey),
                            ),
                            minVerticalPadding: 15,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${selectedOptions.map((e) => e.variation!.value)}"),
                                IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: Adaptive.h(5),
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                ),
                                Text("100,000원"),
                              ],
                            ),
                          ),
                          purchaseSummary(),
                        ],
                      ),
                    ),
                  )
                : SizedBox(height: 0),
            Container(
              height: Adaptive.h(10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
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
        ),
      );
    });
  }

  List<Widget> optionPurchase(List<Option> options) {
    return List.generate(
        options.length,
        (i) => Card(
              child: ExpansionTile(
                  key: GlobalKey(),
                  title: RichText(
                    text:
                        TextSpan(style: theme.textTheme.bodyText1!, children: [
                      TextSpan(text: "${options[i].name} "),
                      TextSpan(
                          text:
                              "${selectedOptions[i].variation == null ? "" : selectedOptions[i].variation!.value}"),
                    ]),
                  ),
                  // maintainState: true,
                  initiallyExpanded: i == selected,
                  children: ListTile.divideTiles(
                      color: Colors.grey[200],
                      tiles: List.generate(
                          options[i].variations!.length,
                          (index) => ListTile(
                                title: Text(
                                    "${options[i].variations![index].value}"),
                                onTap: () {
                                  setState(() {
                                    selectedOptions[i] = selectedOptions[i]
                                        .copyWith(
                                            variation:
                                                options[i].variations![index]);
                                    selected = selected + 1;
                                  });
                                },
                              ))).toList()),
            ));
  }

  Widget purchaseSummary() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: theme.dividerColor),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("총 1개의 상품"),
          RichText(
            text: TextSpan(style: theme.textTheme.bodyText2, children: [
              TextSpan(text: "총 금액 "),
              TextSpan(
                  text: "100,000원",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
            ]),
          )
        ],
      ),
    );
  }

  List<Widget> productQuantity() {
    return [
      Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "수량",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Adaptive.sp(15)),
            ),
          ],
        ),
      )
    ];
  }
}
