import 'package:aroundus_app/modules/magazine/magazine_home/view/components/todays_magazine_widget.dart';
import 'package:aroundus_app/modules/brands/brand_detail/cubit/brand_detail_cubit.dart';
import 'package:aroundus_app/support/base_component/title_with_underline.dart';
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
                          radius: sizeWidth(3)),
                      SizedBox(width: sizeWidth(5)),
                      Text(state.name!,
                          style: Theme.of(context).textTheme.headline5)
                    ]),
                    SizedBox(height: sizeWidth(5)),
                    Text(state.description!),
                    Divider(height: Adaptive.h(5))
                  ])),
          LeftPageWire(
            child: Column(
              children: [
                TitleWithUnderline(
                    title: 'BRAND MAGS',
                    subtitle: '${state.name!}에서 직접 운영하는 브랜드 스토리입니다.'),
                // state.brandDetail!.magazines! != []
                //     ? TodaysMagazine(state.brandDetail!.magazines!)
                //     : Container()
              ],
            ),
          ),
          PageWire(
            child: Container(color: Colors.grey, height: 100),
          )
        ]));
      }
      return Center(child: CircularProgressIndicator());
    });
  }
}
