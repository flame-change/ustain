import 'package:aroundus_app/modules/orderForm/cubit/orderForm_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'orderForm_page.dart';

class OrderFormListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderFormListPageState();
}

class _OrderFormListPageState extends State<OrderFormListPage> {
  late OrderFormCubit _orderFormCubit;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _orderFormCubit = BlocProvider.of<OrderFormCubit>(context);
    _scrollController.addListener(_onScroll);
    _orderFormCubit.getOrderForm();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0) {
      _orderFormCubit.getOrderForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderFormCubit, OrderFormState>(
        builder: (context, state) {
      return PageWire(
        child: BlocBuilder<OrderFormCubit, OrderFormState>(
            builder: (context, state) {
          if (state.isLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) => Container(
                height: Adaptive.h(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("${state.orderForm![index].orderDate}",
                        style: theme.textTheme.headline5!
                            .copyWith(color: Color(0xFF606060))),
                    Blank(height: 6, color: Colors.black),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(
                          state.orderForm![index].itemsInfo!.length,
                          (i) => GestureDetector(
                                onTap: () {
                                  print("orderForm.orderDate ${state.orderForm![index].Id!}");
                                  print("orderForm.orderDate ${state.orderForm![index].orderDate}");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BlocProvider<
                                                  OrderFormCubit>.value(
                                              value: _orderFormCubit,
                                              child: OrderFormPage(
                                                  state.orderForm![index].Id!,
                                                  true))));
                                  // _orderFormCubit.getOrderForm();
                                },
                                child: Container(
                                  width: Adaptive.w(100),
                                  height: Adaptive.h(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 85,
                                          height: 85,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${state.orderForm![index].itemsInfo![i].productThumbnail}"))),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${state.orderForm![index].itemsInfo![i].status}",
                                                  style: theme
                                                      .textTheme.headline5!
                                                      .copyWith(
                                                          color: theme
                                                              .accentColor),
                                                ),
                                                Text(
                                                    "${state.orderForm![index].itemsInfo![i].productName}",
                                                    style: theme
                                                        .textTheme.headline5),
                                                Text(
                                                    "${state.orderForm![index].itemsInfo![i].variantName}",
                                                    style: theme
                                                        .textTheme.subtitle2!
                                                        .copyWith(
                                                            fontSize:
                                                                Adaptive.dp(
                                                                    10))),
                                                Text(
                                                    "수량 : ${state.orderForm![index].itemsInfo![i].quantity}개",
                                                    style: theme
                                                        .textTheme.subtitle2!
                                                        .copyWith(
                                                            fontSize:
                                                                Adaptive.dp(
                                                                    10))),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                  "${currencyFromString(state.orderForm![index].itemsInfo![i].salePrice.toString())}",
                                                  style: theme
                                                      .textTheme.headline5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                    )
                  ],
                ),
              ),
              itemCount: state.orderForm!.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      );
    });
  }
}
