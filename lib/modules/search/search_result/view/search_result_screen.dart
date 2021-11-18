import 'package:aroundus_app/modules/search/search_result/view/search_result_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  static String routeName = '/search_result_screen';

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SearchResultPage();
  }
}
