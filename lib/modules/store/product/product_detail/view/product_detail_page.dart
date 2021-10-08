import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/modules/store/product/product_detail/components/product_sale_bottom_navigator.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

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
        bottomNavigationBar: productSaleBottomNavigator(context, _productCubit),
        body:
            BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          if (state.isLoaded) {
            product = state.products!.first;
            return Column(
              children: [
                Container(
                  height: 50.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(product.thumbnail!))),
                  child: PageWire(
                    child: Container(
                      width: 100.w,
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_outlined),
                            iconSize: 20,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                    top: false,
                    child: Container(
                      padding: basePadding(vertical: 20),
                      child: Wrap(
                        runSpacing: 15,
                        spacing: 20,
                        children: [
                          // categoryTag(context, product.socialValues!),
                          GestureDetector(
                            onTap: () {
                              // TODO 브랜드 페이지 이동
                              print("브랜드 페이지 이동");
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(product.brand!.url!),
                                      )),
                                ),
                                Text(
                                  "${product.brand!.name}",
                                  style: theme.textTheme.button,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${product.name}",
                            style: theme.textTheme.headline4,
                          ),
                          Html(
                            data: product.description,
                          ),
                          Divider(),
                          RichText(
                            text: TextSpan(
                                style: theme.textTheme.headline4,
                                children: [
                                  TextSpan(
                                      text:
                                          "${currencyFromString(product.discountPrice.toString())}\n",
                                      style: theme.textTheme.subtitle1!
                                          .copyWith(
                                              fontSize: Adaptive.dp(12),
                                              decoration:
                                                  TextDecoration.lineThrough)),
                                  TextSpan(
                                      text: "${product.discountRate}%\t",
                                      style: TextStyle(
                                        fontSize: Adaptive.dp(15),
                                      )),
                                  TextSpan(
                                    text:
                                        "${currencyFromString(product.discountPrice.toString())}",
                                    style: TextStyle(
                                        fontSize: Adaptive.sp(20),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ))
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
