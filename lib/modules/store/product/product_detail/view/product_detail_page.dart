import 'package:aroundus_app/modules/store/product/product_detail/components/product_sale_bottom_navigator.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/view/components/magazine_card_widget.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/brands/brand_detail/cubit/brand_detail_cubit.dart';
import 'package:aroundus_app/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
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

  int _selectedIndex = 0;

  late ProductCubit _productCubit;
  late BrandDetailCubit _brandDetailCubit;
  late List<Magazine> magazineList;

  late bool is_authenticated;
  late Product product;

  @override
  void initState() {
    super.initState();
    is_authenticated = context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated;
    _productCubit = BlocProvider.of<ProductCubit>(context);
    _brandDetailCubit = BlocProvider.of<BrandDetailCubit>(context);

    magazineList = [];

    _productCubit.getProductDetail(_productId).whenComplete(() {
      product = _productCubit.state.products!.first;
      _brandDetailCubit
          .getBrandMagazines(product.brand!.Id!)
          .whenComplete(() => setState(() {
                var magazines = _brandDetailCubit.state.magazines as List;
                magazineList = List<Magazine>.from(magazines.map((model) =>
                    Magazine(
                        model['id'],
                        model['title'],
                        model['subtitle'],
                        model['bannerImage'],
                        (model['categories'] as List)
                            .map((item) => item as String)
                            .toList(),
                        model['content'])));
              }));
      print(magazineList);
      print('----------------');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: productSaleBottomNavigator(
            context, _productCubit, is_authenticated),
        body:
            BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          if (state.isLoaded == true) {
            return CustomScrollView(slivers: [
              SliverAppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: true,
                  floating: false,
                  pinned: true,
                  snap: false,
                  iconTheme: IconThemeData(color: Colors.black),
                  expandedHeight: Adaptive.h(55),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Stack(children: [
                    Image.network(product.thumbnail!,
                        fit: BoxFit.cover,
                        height: Adaptive.h(55),
                        width: sizeWidth(100))
                  ])),
                  actions: [
                    GestureDetector(
                        onTap: () => is_authenticated == true
                            ? Navigator.pushNamed(context, '/cart_screen')
                            : showLoginNeededDialog(context),
                        child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: SvgPicture.asset("assets/icons/cart.svg")))
                  ],
                  bottom: PreferredSize(
                      preferredSize: Size(sizeWidth(100), Adaptive.h(5.5)),
                      child: Row(children: [
                        InkWell(
                            onTap: () => setState(() => _selectedIndex = 0),
                            child: _detailTab(context, 0, "SPECS", 50)),
                        InkWell(
                            onTap: () => setState(() => _selectedIndex = 1),
                            child: _detailTab(context, 1, "MAGS", 50))
                      ]))),
              SliverToBoxAdapter(
                  child: _selectedIndex == 0
                      ? Padding(padding: EdgeInsets.all(20), child: firstPage())
                      : secondPage(context))
            ]);
          } else {
            return Container();
          }
        }));
  }

  Container _detailTab(
      BuildContext context, int index, String title, int Width) {
    return Container(
        decoration: BoxDecoration(
            color: _selectedIndex == index ? Colors.black : Colors.white,
            border: Border.all(color: Colors.black)),
        width: sizeWidth(Width),
        height: Adaptive.h(5.5),
        child: Center(
            child: Text(title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: _selectedIndex == index
                        ? Colors.white
                        : Colors.black))));
  }

  Column firstPage() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
          onTap: () => Navigator.pushNamed(context, BrandDetailScreen.routeName,
              arguments: {'Id': product.brand!.Id!}),
          child: Row(children: [
            Container(
                width: sizeWidth(5),
                height: sizeWidth(5),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(product.brand!.url!)))),
            Text("${product.brand!.name}", style: theme.textTheme.button)
          ])),
      SizedBox(height: sizeWidth(3)),
      Text("${product.name}", style: theme.textTheme.headline4),
      if (product.summary != '') SizedBox(height: sizeWidth(3)),
      if (product.summary != '') Text("${product.summary}"),
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
      Html(data: product.description, shrinkWrap: true, customImageRenders: {
        networkSourceMatcher(): networkImageRender(
            loadingWidget: () => Container(color: Colors.white))
      })
    ]);
  }

  Padding secondPage(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: magazineList.isNotEmpty
            ? Column(children: [
                for (var magazine in magazineList)
                  magazineCard(context, magazine),
              ])
            : Center(
                child: Text('아직 매거진을 준비중이에요 :)',
                    style: Theme.of(context).textTheme.headline5),
              ));
  }
}
