import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class PlainButton extends StatefulWidget {

  PlainButton({required this.text, this.size, required this.onPressed});

  final String text;
  final int? size;
  final VoidCallback? onPressed;

  @override
  _PlainButtonState createState() => _PlainButtonState();
}

class _PlainButtonState extends State<PlainButton> {
  String get _text => this.widget.text;
  int? get _size => this.widget.size==null?100:this.widget.size;
  VoidCallback? get _onPressed => this.widget.onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adaptive.w(_size!),
      child: MaterialButton(
        onPressed: _onPressed,
        color: Colors.grey,
        child: Text(_text),
      ),
    );
  }
}