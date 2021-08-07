import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PlainButton extends StatefulWidget {

  PlainButton({required this.text, this.size});

  final String text;
  final int? size;

  @override
  _PlainButtonState createState() => _PlainButtonState();
}

class _PlainButtonState extends State<PlainButton> {
  String get _text => this.widget.text;
  int? get _size => this.widget.size==null?100:this.widget.size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size!.w,
      child: MaterialButton(
        onPressed: () {},
        color: Colors.grey,
        child: Text(_text),
      ),
    );
  }
}