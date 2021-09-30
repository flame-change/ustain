import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export 'package:sizer/sizer.dart';


class StorePage extends StatefulWidget {
  static String routeName = 'store_page';

  @override
  State<StatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  late StoreCubit _storeCubit;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    // _storeCubit.getCollection();
  }

  @override
  Widget build(BuildContext context) {
    return PageWire(
      child: Center(
        child: Text("스토어 페이지 홈"),
        // child: CircularProgressIndicator(),
      ),
    );
  }
}