import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/store/store_home/components/store_product_widget.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:aroundus_app/repositories/product_repository/models/product.dart';
import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export 'package:sizer/sizer.dart';

class StorePage extends StatefulWidget {
  static String routeName = 'store_page';

  final Collection selectedMenu;

  StorePage(this.selectedMenu);

  @override
  State<StatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> with SingleTickerProviderStateMixin {
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
    if(currentMenu != _selectedMenu){
      _storeCubit.getProductsByCollection(_selectedMenu, "price.sale");
    }
    return BlocBuilder<StoreCubit, StoreState>(
        builder: (context, state) {
          if (state.products != null) {
            return ListView.builder(
              itemBuilder: (context, index) => storeProduct(state.products![index]),
              itemCount: state.products!.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
