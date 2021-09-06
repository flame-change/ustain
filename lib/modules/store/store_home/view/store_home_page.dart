import 'package:aroundus_app/modules/store/cubit/store_cubit.dart';
import 'package:flutter/material.dart';
export 'package:sizer/sizer.dart';


class StorePage extends StatefulWidget {
  static String routeName = 'store_page';

  @override
  State<StatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}