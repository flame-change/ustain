import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/store/store_home/components/store_product_widget.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
export 'package:sizer/sizer.dart';

class StorePage extends StatefulWidget {
  static String routeName = 'store_page';

  final Collection selectedMenu;

  StorePage(this.selectedMenu);

  @override
  State<StatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with SingleTickerProviderStateMixin {
  Collection get _selectedMenu => this.widget.selectedMenu;

  late StoreCubit _storeCubit;
  late User user;
  late Collection currentMenu;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    user = context.read<AuthenticationBloc>().state.user;
    currentMenu = _selectedMenu;
    _storeCubit.getProductsByCollection(_selectedMenu, "price.sale");
  }

  @override
  Widget build(BuildContext context) {
    if (currentMenu != _selectedMenu) {
      _storeCubit.getProductsByCollection(_selectedMenu, "price.sale");
    }
    return BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
      if (state.products != null) {
        return Container(
          height: Adaptive.h(100),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25))),
          child: SingleChildScrollView(
            padding: basePadding(),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Adaptive.h(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PRODUCT",
                        style: theme.textTheme.headline4!.copyWith(
                            color: theme.accentColor, fontWeight: FontWeight.w900),
                      ),
                      Text("인기순 필터")
                    ],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 15,
                  childAspectRatio: (4 / 7),
                  children: List.generate(state.products!.length,
                      (index) => storeProduct(context, state.products![index])),
                ),
              ],
            ),
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
