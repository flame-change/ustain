import 'package:aroundus_app/modules/store/product/product_detail/components/product_sale_bottom_navigator.dart';
import 'package:aroundus_app/modules/store/product/product_detail/components/product_detail_tabs.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

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
  ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  final sliverMinHeight = Adaptive.h(10) + AppBar().preferredSize.height;
  final sliverMaxHeight = Adaptive.h(55);

  @override
  void initState() {
    super.initState();
    user_status = context.read<AuthenticationBloc>().state.status;
    _productCubit = BlocProvider.of<ProductCubit>(context);
    _productCubit.getProductDetail(_productId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
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
            return NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: headerSliverBuilder,
                body: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: mainPageView()));
          } else {
            return Container();
          }
        }));
  }

  List<Widget> headerSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                  minHeight: sliverMinHeight,
                  maxHeight: sliverMaxHeight,
                  minChild: minTopChild(context, user_status),
                  maxChild: topChild())))
    ];
  }

  Widget minTopChild(context, user_status) {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: AppBar().preferredSize.height),
          child: appbarRow(context: context, user_status: user_status)),
      pageButtonLayout()
    ]);
  }

  Widget topChild() {
    return Column(children: <Widget>[
      Stack(children: [
        Image.network(product.thumbnail!,
            fit: BoxFit.cover, width: Adaptive.w(100), height: Adaptive.h(50)),
        Padding(
            padding:
                EdgeInsets.symmetric(vertical: AppBar().preferredSize.height),
            child: appbarRow(context: context, user_status: user_status))
      ]),
      pageButtonLayout()
    ]);
  }

  Widget pageButtonLayout() {
    return SizedBox(
        height: Adaptive.h(5),
        child: Row(children: <Widget>[
          Expanded(child: pageButton("SPECS", 0)),
          Expanded(child: pageButton("REVIEWS", 1)),
          Expanded(child: pageButton("INFO", 2))
        ]));
  }

  Widget pageButton(String title, int page) {
    final fontColor = pageIndex == page ? Colors.white : Colors.black;
    final lineColor = pageIndex == page ? Colors.black : Colors.white;

    return InkWell(
        splashColor: Color(0xFF204D7E),
        onTap: () => pageBtnOnTap(page),
        child: Column(children: <Widget>[
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: lineColor),
                  width: double.infinity,
                  height: Adaptive.h(3),
                  child: Center(
                    child: Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: fontColor)),
                  )))
        ]));
  }

  pageBtnOnTap(int page) {
    setState(() {
      pageIndex = page;
      _pageController.animateToPage(pageIndex,
          duration: Duration(milliseconds: 700), curve: Curves.easeOutCirc);
    });
  }

  Widget mainPageView() {
    return PageView(
        controller: _pageController,
        children: <Widget>[
          pageItem(firstPage()),
          pageItem(Center(
            child: Text(
              "page 2\n\n두번재\n\n페이지\n\n스크롤이\n\n되도록\n\n내용을\n\n길게\n\n길게",
              style: TextStyle(fontSize: 50),
            ),
          )),
          pageItem(thirdPage())
        ],
        onPageChanged: (index) => setState(() => pageIndex = index));
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

  Widget pageItem(Widget child) {
    double statusHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double minHeight = height - statusHeight - sliverMinHeight;

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
                top: Adaptive.h(13), left: Adaptive.w(5), right: Adaptive.w(5)),
            color: Colors.white,
            constraints: BoxConstraints(minHeight: minHeight),
            child: child));
  }
}
