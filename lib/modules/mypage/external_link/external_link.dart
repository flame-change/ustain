import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExternalLink extends StatefulWidget {
  ExternalLink({@required this.url});

  final String? url;

  @override
  State<ExternalLink> createState() => _ExternalLinkState();
}

class _ExternalLinkState extends State<ExternalLink> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        body: SafeArea(
            child: Stack(children: <Widget>[
          WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() => isLoading = false);
              }),
          isLoading ? Center(child: CircularProgressIndicator()) : Stack()
        ])));
  }
}
