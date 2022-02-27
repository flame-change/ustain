import 'package:aroundus_app/modules/store/product/product_detail/components/product_sale_bottom_navigator.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/modules/brands/brand_detail/cubit/brand_detail_cubit.dart';
import 'package:aroundus_app/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/modules/store/product/cubit/product_cubit.dart';
import 'package:aroundus_app/modules/store/cart/view/cart_screen.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';
import 'package:aroundus_app/support/style/format_unit.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../components/magazine_card.dart';
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

  late BrandDetailCubit _brandDetailCubit;
  late TabController _tabController;
  late List<Magazine> magazineList;
  late ProductCubit _productCubit;
  late bool is_authenticated;
  late Product product;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        bottomNavigationBar: productSaleBottomNavigator(
            context, _productCubit, is_authenticated),
        body:
            BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          if (state.isLoaded == true) {
            return bodyWidget(context);
          } else {
            return Container();
          }
        }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black87,
            child:
                SvgPicture.asset("assets/icons/cart.svg", color: Colors.white),
            onPressed: () => is_authenticated == true
                ? Navigator.pushNamed(context, CartScreen.routeName)
                : showLoginNeededDialog(context)));
  }

  DefaultTabController bodyWidget(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                appBarWidget(context),
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverPersistentHeader(
                        pinned: true, delegate: TabBarDelegate()))
              ];
            },
            body: Column(children: [
              SizedBox(height: 80),
              Expanded(
                  child: TabBarView(children: [
                CustomScrollView(
                    slivers: [SliverToBoxAdapter(child: firstPage())]),
                CustomScrollView(
                    slivers: [SliverToBoxAdapter(child: secondPage(context))])
              ]))
            ])));
  }

  SliverAppBar appBarWidget(BuildContext context) {
    return SliverAppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        pinned: false,
        floating: true,
        snap: false,
        toolbarHeight: Adaptive.h(50),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(
            background: Stack(
                clipBehavior: Clip.none,
                overflow: Overflow.visible,
                children: [
              Image.network(product.thumbnail!,
                  fit: BoxFit.cover,
                  height: Adaptive.h(50),
                  width: sizeWidth(100)),
              Positioned(
                  height: Adaptive.h(20),
                  width: sizeWidth(100),
                  bottom: 47,
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(1)
                      ])))),
              Positioned(
                  bottom: 0,
                  child: Container(
                      width: Adaptive.w(100),
                      padding: EdgeInsets.symmetric(horizontal: sizeWidth(5)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, BrandDetailScreen.routeName,
                                    arguments: {'Id': product.brand!.Id!}),
                                child: Row(children: [
                                  Container(
                                      width: sizeWidth(5),
                                      height: sizeWidth(5),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  product.brand!.url!)))),
                                  Text("${product.brand!.name} >",
                                      style: theme.textTheme.headline6)
                                ])),
                            SizedBox(height: 3),
                            WrappedKoreanText("${product.name}",
                                style: theme.textTheme.headline5),
                            if (product.summary != '') SizedBox(height: 3),
                            if (product.summary != '')
                              WrappedKoreanText("${product.summary}"),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                    '${currencyFromString(product.discountPrice.toString())}',
                                    style:
                                        Theme.of(context).textTheme.headline5))
                          ]))),
              Container(
                  padding: EdgeInsets.symmetric(
                      vertical: AppBar().preferredSize.height, horizontal: 18),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            child: Icon(Icons.arrow_back_ios_outlined,
                                color: Colors.black54),
                            onTap: () => Navigator.pop(context))
                      ]))
            ])));
  }

  Padding firstPage() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(3)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 50),
          Html(
              data: product.description,
              shrinkWrap: true,
              customImageRenders: {
                networkSourceMatcher(): networkImageRender(
                    loadingWidget: () => Container(
                        color: Theme.of(context).scaffoldBackgroundColor))
              })
        ]));
  }

  Padding secondPage(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 50),
        child: magazineList.isNotEmpty
            ? Column(children: [
                for (var magazine in magazineList)
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeWidth(5), vertical: 10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(sizeWidth(5)),
                          child: magazineCard(context, magazine))),
              ])
            : Center(
                child: Column(children: [
                Icon(Icons.info_outline, color: Colors.black),
                SizedBox(height: 3),
                Text('아직 매거진을 준비중이에요.')
              ])));
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
            padding: EdgeInsets.only(left: sizeWidth(5)),
            child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: Adaptive.dp(18)),
                isScrollable: true,
                tabs: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text('SPECS')),
                  Padding(
                      padding: EdgeInsets.only(right: 20), child: Text('MAGS'))
                ],
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: Colors.black),
                    insets: EdgeInsets.only(bottom: 0)),
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.only(right: 20))));
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
