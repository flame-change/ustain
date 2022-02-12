import 'package:aroundus_app/modules/magazine/magazine_home/view/components/todays_magazine_widget.dart';
import 'package:aroundus_app/modules/brands/brand_detail/cubit/brand_detail_cubit.dart';
import 'package:aroundus_app/modules/store/store_home/components/store_product_widget.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/repositories/product_repository/models/brand.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BrandDetailPage extends StatefulWidget {
  BrandDetailPage({@required this.Id});

  final String? Id;

  @override
  _BrandDetailPageState createState() => _BrandDetailPageState();
}

class _BrandDetailPageState extends State<BrandDetailPage> {
  late BrandDetailCubit _brandDetailCubit;

  @override
  void initState() {
    super.initState();
    _brandDetailCubit = BlocProvider.of<BrandDetailCubit>(context);
    _brandDetailCubit.getBrandDetail(widget.Id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandDetailCubit, BrandDetailState>(
        builder: (context, state) {
      if (state.isLoaded == true) {
        var products = state.products as List;
        List<Product> productList = List<Product>.from(products.map((model) =>
            Product(
                Id: model['Id'],
                name: model['name'],
                rating: model['rating'],
                originalPrice: model['originalPrice'],
                discountPrice: model['discountPrice'],
                discountRate: model['discountRate'],
                thumbnail: model['thumbnail'],
                brand: Brand(name: model['brand']))));

        return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(
                  top: sizeWidth(5), left: sizeWidth(5), right: sizeWidth(5)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(state.logo!),
                          radius: sizeWidth(5)),
                      SizedBox(width: sizeWidth(3)),
                      Text(state.name!,
                          style: Theme.of(context).textTheme.headline5)
                    ]),
                    SizedBox(height: sizeWidth(5)),
                    Text(state.description!),
                    Divider(height: Adaptive.h(5))
                  ])),
          LeftPageWire(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('BRAND MAGS',
                    style: Theme.of(context).textTheme.headline5),
                SizedBox(height: sizeWidth(5)),
                state.magazines!.length != 0
                    ? TodaysMagazine(
                        todaysMagazines: List<Magazine>.from(state.magazines!
                            .map((model) => Magazine.fromJson(model))),
                        isMain: false)
                    : Container(
                        color: Colors.white,
                        height: Adaptive.h(20),
                        child: Center(child: Text('아직 등록된 브랜드 스토리가 없습니다.')))
              ])),
          Padding(
              padding: EdgeInsets.only(left: sizeWidth(5), right: sizeWidth(5)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PRODUCTS',
                        style: Theme.of(context).textTheme.headline5),
                    SizedBox(height: sizeWidth(5)),
                    productList.length != 0
                        ? GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 15,
                            childAspectRatio: (4 / 7),
                            children: List.generate(
                                state.products!.length,
                                (index) =>
                                    storeProduct(context, productList[index])))
                        : Container(
                            color: Colors.white,
                            height: Adaptive.h(20),
                            child: Center(child: Text('아직 등록된 상품이 없습니다.')))
                  ]))
        ]));
      }
      return Center(
          child: Image.asset('assets/images/indicator.gif',
              width: 100, height: 100));
    });
  }
}
