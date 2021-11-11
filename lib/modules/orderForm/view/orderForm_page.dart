import 'package:aroundus_app/modules/orderForm/cubit/orderForm_cubit.dart';
import 'package:aroundus_app/repositories/order_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class OrderFormPage extends StatefulWidget {
  OrderFormPage(this.orderId, this.viewingNavigator);

  final String orderId;
  final bool viewingNavigator;

  @override
  State<StatefulWidget> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage>
    with SingleTickerProviderStateMixin {
  String get orderId => this.widget.orderId;

  bool get viewingNavigator => this.widget.viewingNavigator;

  late OrderFormCubit _orderFormCubit;
  late OrderForm orderForm;

  @override
  void initState() {
    super.initState();
    _orderFormCubit = BlocProvider.of<OrderFormCubit>(context);
    _orderFormCubit.getOrderFormById(orderId);
  }

  @override
  void dispose() {
    super.dispose();
    _orderFormCubit.getOrderForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: viewingNavigator
            ? AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
              )
            : AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: false,
                title: GestureDetector(
                    child: Icon(Icons.arrow_back_ios_outlined,
                        color: Colors.black),
                    onTap: () {
                      Navigator.pushNamed(context, 'main_screen');
                    }),
              ),
        body: BlocBuilder<OrderFormCubit, OrderFormState>(
          builder: (context, state) {
            if (state.isLoaded) {
              orderForm = _orderFormCubit.state.orderForm!.first;
              return PageWire(
                  child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${orderForm.orderDate}",
                        style: theme.textTheme.headline4),
                    Blank(color: Colors.black, height: 6),
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) => Row(
                                children: [
                                  Container(
                                    width: 85,
                                    height: 85,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${orderForm.itemsInfo![index].productThumbnail}"))),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${orderForm.itemsInfo!.first.productName}",
                                            style: theme.textTheme.headline5),
                                        Text(
                                          "${orderForm.itemsInfo![index].variantName}",
                                          style: theme.textTheme.subtitle2!
                                              .copyWith(
                                                  fontSize: Adaptive.dp(10)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "수량 : ${orderForm.itemsInfo![index].quantity}개"),
                                            Text(
                                                "${currencyFromString(orderForm.itemsInfo![index].salePrice.toString())}",
                                                style:
                                                    theme.textTheme.headline5),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                          itemCount: orderForm.itemsInfo!.length),
                    )
                  ],
                ),
              ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
