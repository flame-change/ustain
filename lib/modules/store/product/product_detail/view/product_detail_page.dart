import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage(this.productId);

  final String productId;

  @override
  State<StatefulWidget> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  String get _productId => this.widget.productId;

  late Product product;

  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = BlocProvider.of<ProductCubit>(context);
    _productCubit.getProductDetail(_productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:
            BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          if (state.isLoaded) {
            product = state.products!.first;
            return Column(
              children: [
                Container(
                    height: 45.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(product.thumbnail!)))),
                PageWire(
                    child: Column(
                  children: [
                    Text("product detail page"),
                    Text(
                      "${product.brand!.name}",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${product.name}",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
