import 'package:aroundus_app/modules/search/search_result/view/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.black38.withAlpha(10),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(children: <Widget>[
          Expanded(
              child: TextField(
                  autofocus: true,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))))),
          IconButton(
              icon: Icon(Icons.search),
              color: Colors.black.withAlpha(120),
              onPressed: () {
                if (_textEditingController.text.trim() != '') {
                  Navigator.pushNamed(context, SearchResultScreen.routeName,
                      arguments: {'keyword': _textEditingController.text});
                  _textEditingController.clear();
                } else {
                  showTopSnackBar(
                      context, CustomSnackBar.error(message: "검색어를 입력해주세요."));
                }
              })
        ]));
  }
}
