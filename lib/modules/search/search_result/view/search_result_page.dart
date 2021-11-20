import 'package:aroundus_app/modules/search/search_result/cubit/search_result_cubit.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({required this.keyword});

  final String keyword;

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late SearchResultCubit _searchResultCubit;

  @override
  void initState() {
    super.initState();
    _searchResultCubit = BlocProvider.of<SearchResultCubit>(context);
    _searchResultCubit.search(widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: LeftPageWire(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('준비중입니다.')])));
  }
}
