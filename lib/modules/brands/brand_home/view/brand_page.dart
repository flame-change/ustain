import 'package:aroundus_app/modules/brands/brand_home/components/brand_list_tile.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
import 'package:aroundus_app/modules/brands/brand_home/cubit/brand_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/base_component/company_info.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BrandPage extends StatefulWidget {
  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  late BrandCubit _brandCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _brandCubit = BlocProvider.of<BrandCubit>(context);
    _brandCubit.getBrands();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0 && _brandCubit.state.next != null) {
      _brandCubit.getBrands();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      LeftPageWire(
          child: TitleWithUnderline(
              color: Colors.grey.shade100,
              title: 'TRENDING BRANDS',
              subtitle: '인기 브랜드의 진솔한 뒷이야기.')),
      PageWire(child:
          BlocBuilder<BrandCubit, BrandListState>(builder: (context, state) {
        if (state.isLoaded == true) {
          return Column(children: [
            for (var brand in state.brands!)
              BrandListTile(
                  Id: brand.Id,
                  name: brand.name,
                  description: brand.description,
                  logo: brand.logo)
          ]);
        }
        return Padding(
            padding: EdgeInsets.only(top: Adaptive.h(20)),
            child: Center(child: Image.asset('assets/images/indicator.gif')));
      })),
      SizedBox(height: Adaptive.h(5)),
      CompanyInfo()
    ]));
  }
}
