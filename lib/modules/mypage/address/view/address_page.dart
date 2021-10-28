import 'package:aroundus_app/modules/mypage/address/cubit/address_cubit.dart';
import 'package:aroundus_app/modules/mypage/address/view/address_form_page.dart';
import 'package:aroundus_app/modules/mypage/address/view/components/address_tile_widget.dart';
import 'package:aroundus_app/repositories/address_repository/models/address.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressPage extends StatefulWidget {
  @override
  State<AddressPage> createState() => _AddressPage();
}

class _AddressPage extends State<AddressPage> {
  late AddressCubit _addressCubit;

  int selected = 0;

  @override
  void initState() {
    super.initState();
    _addressCubit = BlocProvider.of<AddressCubit>(context);
    _addressCubit.getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(builder: (context, state) {
      if (state.isLoaded) {
        return BlocSelector<AddressCubit, AddressState, List<Address?>>(
            selector: (state) => state.addresses!,
            builder: (context, addresses) {
              if (addresses != null && addresses.isNotEmpty) {
                return Stack(
                  children: [
                    PageWire(
                        child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ADDRESS", style: theme.textTheme.headline3),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider<AddressCubit>.value(
                                        value: _addressCubit,
                                        child: AddressFormPage(),
                                      )));
                            },
                            child: Text("배송지 추가",
                                style: theme.textTheme.headline5!.copyWith(
                                    decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 30),
                          child: Column(children: List.generate(
                              addresses.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = index;
                                      });
                                    },
                                    child: addressTile(_addressCubit, addresses[index]!, selected==index),
                                  )))),
                    ])),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          _addressCubit.updateDefaultAddress(state.addresses![selected].id!);
                        },
                        child: Container(
                          height: Adaptive.h(10),
                          width: sizeWith(100),
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: Text(
                            "설정완료",
                            style: theme.textTheme.button!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          'assets/images/empty_cart.svg',
                          height: 80,
                          color: theme.accentColor,
                        ),
                      ),
                      Text(
                        "아무것도 없어요!",
                        style: theme.textTheme.headline2!.copyWith(height: 2),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider<AddressCubit>.value(
                                    value: _addressCubit,
                                    child: AddressFormPage(),
                                  )));
                        },
                        child: Text("배송지 추가",
                            style: theme.textTheme.headline5!.copyWith(
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                );
              }
            });
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
