import 'package:aroundus_app/modules/store/product/product_detail/components/product_sale_bottom_navigator.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  late AuthenticationStatus user_status;
  late TabController _tabController;
  late int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    user_status = context.read<AuthenticationBloc>().state.status;
    _productCubit = BlocProvider.of<ProductCubit>(context);
    _productCubit.getProductDetail(_productId);
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: productSaleBottomNavigator(context, _productCubit),
        body:
            BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          if (state.isLoaded == true) {
            product = state.products!.first;
            return CustomScrollView(shrinkWrap: true, slivers: [
              SliverAppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: true,
                  floating: true,
                  pinned: true,
                  snap: false,
                  iconTheme: IconThemeData(color: Colors.black),
                  expandedHeight: Adaptive.h(55),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(product.thumbnail!,
                          height: Adaptive.h(55),
                          fit: BoxFit.cover,
                          width: Adaptive.w(100))),
                  actions: [
                    GestureDetector(
                        onTap: () =>
                            user_status == AuthenticationStatus.authenticated
                                ? Navigator.pushNamed(context, 'cart_screen')
                                : showLoginNeededDialog(context),
                        child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: SvgPicture.asset("assets/icons/cart.svg")))
                  ],
                  bottom: TabBar(
                      indicatorColor: Colors.black,
                      controller: _tabController,
                      tabs: [
                        Container(
                            height: Adaptive.h(5),
                            child: Center(
                                child: Text("SPECS",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6))),
                        Container(
                            height: Adaptive.h(5),
                            child: Center(
                                child: Text("REVIEWS",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6))),
                        Container(
                            height: Adaptive.h(5),
                            child: Center(
                                child: Text("INFO",
                                    style:
                                        Theme.of(context).textTheme.headline6)))
                      ])),
              SliverToBoxAdapter(
                  child: _selectedIndex == 0
                      ? Padding(padding: EdgeInsets.all(20), child: firstPage())
                      : _selectedIndex == 1
                          ? Center(child: Text('아직 리뷰가 없습니다.'))
                          : Padding(
                              padding: EdgeInsets.all(20), child: thirdPage()))
            ]);
          } else {
            return Container();
          }
        }));
  }

  Column firstPage() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
          onTap: () {
            print("브랜드 페이지 이동");
          },
          child: Row(children: [
            Container(
                width: Adaptive.w(5),
                height: Adaptive.w(5),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(product.brand!.url!)))),
            Text("${product.brand!.name}", style: theme.textTheme.button)
          ])),
      SizedBox(height: Adaptive.w(3)),
      Text("${product.name}", style: theme.textTheme.headline4),
      SizedBox(height: Adaptive.w(3)),
      Text("${product.summary}"),
      Divider(),
      RichText(
          text: TextSpan(style: theme.textTheme.headline4, children: [
        TextSpan(
            text: "${currencyFromString(product.discountPrice.toString())}\n",
            style: theme.textTheme.subtitle1!.copyWith(
                fontSize: Adaptive.dp(12),
                decoration: TextDecoration.lineThrough)),
        TextSpan(
            text: "${product.discountRate}%\t",
            style: TextStyle(fontSize: Adaptive.dp(15))),
        TextSpan(
            text: "${currencyFromString(product.discountPrice.toString())}",
            style: TextStyle(
                fontSize: Adaptive.sp(20), fontWeight: FontWeight.bold))
      ])),
      Center(child: Html(data: product.description))
    ]);
  }

  Wrap thirdPage() {
    return Wrap(children: [
      Text("${product.notices!['title']}",
          style: Theme.of(context).textTheme.bodyText1),
      SizedBox(height: Adaptive.h(5)),
      DataTable(columns: const <DataColumn>[
        DataColumn(
            label: Text('구분', style: TextStyle(fontWeight: FontWeight.w900))),
        DataColumn(
            label: Text('상세 설명', style: TextStyle(fontWeight: FontWeight.w900)))
      ], rows: [
        for (var notice in product.notices!['items'])
          DataRow(cells: <DataCell>[
            DataCell(Text(notice['title'])),
            DataCell(Text(notice['description']))
          ])
      ])
    ]);
  }
}
