import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/modules/magazine/magazine_detail/cubit/magazine_comment_cubit.dart';
import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/repositories/repositories.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adaptive.h(45),
      padding: EdgeInsets.only(top: Adaptive.h(5)),
      child: PageWire(
        child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, comments) {
          return Wrap(
            runSpacing: 15,
            children: optionPurchase(_product.options!) + productQuantity(),
          );
        }),
      ),
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
                        fontWeight: FontWeight.bold, fontSize: Adaptive.sp(20)),
                  ),
                  Container(
                    height: Adaptive.h(5),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: options[i].variations!.length,
                      itemBuilder: (context, j) => GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Container(
                            color: Colors.grey,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              "${options[i].variations![j].value}",
                            ),
                          ),
                        ),
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
                fontWeight: FontWeight.bold, fontSize: Adaptive.sp(20)),
          ),
          Container(
            height: Adaptive.h(5),
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                  color: Colors.grey
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.remove), onPressed: () {},),
                Text("1"),
                IconButton(icon: Icon(Icons.add), onPressed: () {},),
              ],
            ),
          )
        ],
      )
    ];
  }
}
